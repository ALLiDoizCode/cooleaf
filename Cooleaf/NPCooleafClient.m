//
//  NPCooleafClient.m
//  Cooleaf
//
//  Created by Bazyli Zygan on 14.12.2013.
//  Copyright (c) 2013 Nova Project. All rights reserved.
//

#import "NPCooleafClient.h"
#import <SSKeychain/SSKeychain.h>
#import "NSFileManager+ImageCaching.h"

@interface NPCooleafClient ()
{
    NSMutableDictionary *_downloadedImages;
    NSMutableDictionary *_imageRequests;
}

@property (nonatomic, copy) NSString *apiPrefix;

- (void)synchronizeImageIndex;
@end

@implementation NPCooleafClient

static NSString * const kNPCooleafClientBaseURLString = @"http://cooleaf-staging.h1.monterail.eu";
static NSString * const kNPCooleafClientAPIPrefix = @"/api/v1";
static NSString * const kNPCooleafClientAPIAuthLogin = @"cooleaf";
static NSString * const kNPCooleafClientAPIAuthPassword = @"letmein";

+ (NPCooleafClient *)sharedClient
{
    static NPCooleafClient *_sharedClient = nil;
    static dispatch_once_t oncePredicate;
    if (!_sharedClient)
        dispatch_once(&oncePredicate, ^{
            _sharedClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:kNPCooleafClientBaseURLString]];
        });
    
    return _sharedClient;
}

- (instancetype)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    if (self)
    {
        _apiPrefix = kNPCooleafClientAPIPrefix;
        AFHTTPRequestSerializer *reqSerializer = [AFHTTPRequestSerializer serializer];
        if (kNPCooleafClientAPIAuthLogin.length > 0)
            [reqSerializer setAuthorizationHeaderFieldWithUsername:kNPCooleafClientAPIAuthLogin password:kNPCooleafClientAPIAuthPassword];
//        [reqSerializer setValue:@"coca-cola" forHTTPHeaderField:@"X-Organization"];
        self.requestSerializer = reqSerializer;
        self.responseSerializer = [AFJSONResponseSerializer serializer];
        NSMutableDictionary *imageIndex = [[NSKeyedUnarchiver unarchiveObjectWithFile:[[[[NSFileManager defaultManager] cacheDirectory] URLByAppendingPathComponent:@"index.dat"] path]] mutableCopy];
        if (!imageIndex)
            imageIndex = [NSMutableDictionary new];
        _downloadedImages = imageIndex;
        _imageRequests = [NSMutableDictionary new];
        
    }
    
    return self;
    
}

- (AFHTTPRequestOperation *)loginWithUsername:(NSString *)username password:(NSString *)password  completion:(void(^)(NSError *error))completion
{
    NSString *path = @"/authorize.json";
    
    if (_apiPrefix.length > 0)
        path = [_apiPrefix stringByAppendingString:path];
    return [self POST:path parameters:@{@"email": username, @"password": password} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        _userData = [responseObject copy];
        [self.requestSerializer setValue:_userData[@"role"][@"organization"][@"subdomain"] forHTTPHeaderField:@"X-Organization"];
        [[NSUserDefaults standardUserDefaults] setObject:username forKey:@"username"];
        [SSKeychain setPassword:password forService:@"cooleaf" account:username];
        if (completion)
            completion(nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [SSKeychain deletePasswordForService:@"cooleaf" account:username];
        if (completion)
            completion(error);
    }];
}

- (void)logout
{
    [SSKeychain deletePasswordForService:@"cooleaf" account:[[NSUserDefaults standardUserDefaults] objectForKey:@"username"]];
    _userData = nil;
}

- (void)fetchEventList:(void(^)(NSArray *events))completion
{
    NSString *path = @"/events.json";
    
    if (_apiPrefix.length > 0)
        path = [_apiPrefix stringByAppendingString:path];
    
    [self GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (completion)
            completion(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (completion)
            completion(nil);
    }];
}

- (void)synchronizeImageIndex
{
    [NSKeyedArchiver archiveRootObject:_downloadedImages toFile:[[[[NSFileManager defaultManager] cacheDirectory] URLByAppendingPathComponent:@"index.dat"] path]];
}

- (void)fetchImage:(NSString *)imagePath completion:(void(^)(NSString *imagePath, UIImage *image))completion
{
    // Check if the image is already downloaded
    if (_downloadedImages[imagePath])
    {
        UIImage *image = [UIImage imageWithContentsOfFile:[[[[NSFileManager defaultManager] cacheDirectory] URLByAppendingPathComponent:_downloadedImages[imagePath]] path]];
        if (completion)
            completion(imagePath, image);
    }
    else
    {
        NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:@"GET" URLString:imagePath parameters:nil];
        AFHTTPRequestOperation *operation = [self HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
            // Save the image information first
            NSData *data = (NSData *)responseObject;
            NSString *filename = [[NSFileManager defaultManager] temporaryFilenameWithExtension:@"jpg"];
            [data writeToURL:[[[NSFileManager defaultManager] cacheDirectory] URLByAppendingPathComponent:filename] atomically:NO];
            _downloadedImages[imagePath] = filename;
            [self synchronizeImageIndex];
            UIImage *image = [UIImage imageWithData:data];
            
            // For all saved actions - trigger
            for (id block in _imageRequests[imagePath])
            {
                void (^completionBlock)(NSString *imagePath, UIImage *image) = block;
                
                completionBlock(imagePath, image);
            }
            [_imageRequests removeObjectForKey:imagePath];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            for (id block in _imageRequests[imagePath])
            {
                void (^completionBlock)(NSString *imagePath, UIImage *image) = block;
                
                completionBlock(imagePath, nil);
            }
            [_imageRequests removeObjectForKey:imagePath];
            
        }];
        
        if (_imageRequests[imagePath])
        {
            [_imageRequests[imagePath] addObject:[completion copy]];
        }
        else
        {
            _imageRequests[imagePath] = [NSMutableArray arrayWithObject:[completion copy]];
        }
        
        operation.responseSerializer = [AFHTTPResponseSerializer new];
        [self.operationQueue addOperation:operation];
    }
}

@end
