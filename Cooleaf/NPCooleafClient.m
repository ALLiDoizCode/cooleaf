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

static NPCooleafClient *_sharedClient = nil;
NSString *f_notificationUDID = nil;

NSString * const kNPCooleafClientRefreshNotification = @"kNPCooleafClientRefreshNotification";
NSString * const kNPCooleafClientRUDIDHarvestedNotification = @"kNPCooleafClientRUDIDHarvestedNotification";
NSString * const kNPCooleafClientSignOut = @"kNPCooleafClientSignOut";

//static NSString * const kNPStagingClientBaseURLString = @"http://api.staging.do.cooleaf.monterail.eu";
//static NSString * const kNPStagingClientAPIPrefix = @"/v1";
//static NSString * const kNPStagingClientAPIAuthLogin = @"cooleaf";
//static NSString * const kNPStagingClientAPIAuthPassword = @"letmein";


static NSString * const kNPCooleafClientBaseURLString = @"http://api.cooleaf.com";
static NSString * const kNPCooleafClientAPIPrefix = @"/v1";
static NSString * const kNPCooleafClientAPIAuthLogin = @"";
static NSString * const kNPCooleafClientAPIAuthPassword = @"";

@interface NPCooleafClient ()
{
    NSMutableDictionary *_downloadedImages;
    NSMutableDictionary *_imageRequests;
    void (^_loginCallbackWaiting)(NSError *error);
    NSDictionary *_loginCredentialsWaiting;
}

@property (nonatomic, copy) NSString *apiPrefix;

- (void)synchronizeImageIndex;
@end

@implementation NPCooleafClient


+ (NPCooleafClient *)sharedClient
{

    if (!_sharedClient)
    {
//        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"staging_environment"])
//            _sharedClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:kNPStagingClientBaseURLString]];
//        else
            _sharedClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:kNPCooleafClientBaseURLString]];
    }
    return _sharedClient;
}

- (instancetype)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    if (self)
    {
        AFHTTPRequestSerializer *reqSerializer = [AFHTTPRequestSerializer serializer];
//        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"staging_environment"])
//        {
//            _apiPrefix = kNPStagingClientAPIPrefix;
//            if (kNPStagingClientAPIAuthLogin.length > 0)
//                [reqSerializer setAuthorizationHeaderFieldWithUsername:kNPStagingClientAPIAuthLogin password:kNPStagingClientAPIAuthPassword];
//        }
//        else
//        {
            _apiPrefix = kNPCooleafClientAPIPrefix;
            if (kNPCooleafClientAPIAuthLogin.length > 0)
                [reqSerializer setAuthorizationHeaderFieldWithUsername:kNPCooleafClientAPIAuthLogin password:kNPCooleafClientAPIAuthPassword];
            
//        }

        self.requestSerializer = reqSerializer;
        self.responseSerializer = [AFJSONResponseSerializer serializer];
        NSMutableDictionary *imageIndex = [[NSKeyedUnarchiver unarchiveObjectWithFile:[[[[NSFileManager defaultManager] cacheDirectory] URLByAppendingPathComponent:@"index.dat"] path]] mutableCopy];
        if (!imageIndex)
            imageIndex = [NSMutableDictionary new];
        _downloadedImages = imageIndex;
        _imageRequests = [NSMutableDictionary new];
        
        if (f_notificationUDID)
            self.notificationUDID = f_notificationUDID;
    }
    
    return self;
    
}

- (void)checkEndpoints
{
//    // Check if endpoint has changed
//    NSString *urlString = ([[NSUserDefaults standardUserDefaults] boolForKey:@"staging_environment"]) ? kNPStagingClientBaseURLString : kNPCooleafClientBaseURLString;
//    
//    if ([urlString isEqualToString:self.baseURL.absoluteString])
//        return;
//    
//    // Well - we need to change the endpoint
//    _sharedClient = nil;
//    [SSKeychain deletePasswordForService:@"cooleaf" account:[[NSUserDefaults standardUserDefaults] objectForKey:@"username"]];
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [[NSNotificationCenter defaultCenter] postNotificationName:kNPCooleafClientSignOut object:nil];
//    });
}

- (void)setNotificationUDID:(NSString *)notificationUDID
{
    _notificationUDID = [notificationUDID copy];
    f_notificationUDID = [notificationUDID copy];
    [[NSNotificationCenter defaultCenter] postNotificationName:kNPCooleafClientRUDIDHarvestedNotification object:_notificationUDID];
}

#pragma mark - Login handling

- (AFHTTPRequestOperation *)loginWithUsername:(NSString *)username password:(NSString *)password  completion:(void(^)(NSError *error))completion
{
    NSString *path = @"/authorize.json";
    
    if (_apiPrefix.length > 0)
        path = [_apiPrefix stringByAppendingString:path];
    
    NSDictionary *params = nil;
    
    if (_notificationUDID.length > 0)
#ifdef DEBUG
        params = @{@"email": username, @"password": password, @"device_id": _notificationUDID, @"sandbox": @YES};
#else
        params = @{@"email": username, @"password": password, @"device_id": _notificationUDID, @"sandbox": @NO};
#endif //DEBUG
    else
        params = @{@"email": username, @"password": password};
    
    return [self POST:path parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
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
    NSString *path = @"/deauthorize.json";
    
    if (_apiPrefix.length > 0)
        path = [_apiPrefix stringByAppendingString:path];
    
    NSDictionary *params = nil;
    if (_notificationUDID.length > 0)
#ifdef DEBUG
        params = @{@"device_id": _notificationUDID, @"sandbox": @YES};
#else
        params = @{@"device_id": _notificationUDID, @"sandbox": @NO};
#endif //DEBUG
    [self POST:path parameters:params success:nil failure:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:kNPCooleafClientSignOut object:nil];
}

#pragma mark - User handling

- (AFHTTPRequestOperation *)updateUserData
{
    NSString *path = @"/users/me.json";
    
    if (_apiPrefix.length > 0)
        path = [_apiPrefix stringByAppendingString:path];
    
    return [self GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        _userData = [responseObject copy];
    } failure:nil];
}

#pragma mark - Event handling

- (AFHTTPRequestOperation *)fetchEventWithId:(NSNumber *)eventId completion:(void(^)(NSDictionary *eventDetails))completion
{
    NSString *path = [NSString stringWithFormat:@"/events/%@.json", eventId];
    
    if (_apiPrefix.length > 0)
        path = [_apiPrefix stringByAppendingString:path];
    
    return [self GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (completion)
            completion(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (completion)
            completion(nil);
    }];
}

- (AFHTTPRequestOperation *)fetchParticipantsForEventWithId:(NSNumber *)eventId completion:(void(^)(NSArray *participants))completion
{
    NSString *path = [NSString stringWithFormat:@"/participations/%@.json", eventId];
    
    if (_apiPrefix.length > 0)
        path = [_apiPrefix stringByAppendingString:path];
    
    return [self GET:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (completion)
            completion(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (completion)
            completion(nil);
    }];
}

- (AFHTTPRequestOperation *)joinEventWithId:(NSNumber *)eventId completion:(void(^)(NSError *error))completion
{
    NSString *path = [NSString stringWithFormat:@"/events/%@/join.json", eventId];
    
    if (_apiPrefix.length > 0)
        path = [_apiPrefix stringByAppendingString:path];
    
    return [self POST:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self updateUserData];
        if (completion)
            completion(nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self updateUserData];
        if (completion)
            completion(error);
    }];
}

- (AFHTTPRequestOperation *)leaveEventWithId:(NSNumber *)eventId completion:(void(^)(NSError *error))completion
{
    NSString *path = [NSString stringWithFormat:@"/events/%@/join.json", eventId];
    
    if (_apiPrefix.length > 0)
        path = [_apiPrefix stringByAppendingString:path];
    return [self DELETE:path parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self updateUserData];        
        if (completion)
            completion(nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self updateUserData];
        if (completion)
            completion(error);
    }];
}




- (void)fetchEventList:(void(^)(NSArray *events))completion
{
    NSString *path = @"/events.json";
    
    if (_apiPrefix.length > 0)
        path = [_apiPrefix stringByAppendingString:path];
    
    [self GET:path parameters:@{@"scope": @"ongoing"} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (completion)
            completion(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (completion)
            completion(nil);
    }];
}

#pragma mark - Image handling

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

#pragma mark - Todos handling

- (AFHTTPRequestOperation *)addTodoForWidget:(NSNumber *)widgetId name:(NSString *)name completion:(void(^)(NSError *error))completion
{
    NSString *path = [NSString stringWithFormat:@"/widgets/todos/%@.json", widgetId];
    
    if (_apiPrefix.length > 0)
        path = [_apiPrefix stringByAppendingString:path];
    return [self POST:path parameters:@{@"name": name} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (completion)
            completion(nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (completion)
            completion(error);
    }];
}

- (AFHTTPRequestOperation *)markTodo:(NSNumber *)todoId asDone:(BOOL)done completion:(void(^)(NSError *error))completion
{
    NSString *path = [NSString stringWithFormat:@"/widgets/todos/%@.json", todoId];
    
    if (_apiPrefix.length > 0)
        path = [_apiPrefix stringByAppendingString:path];
    return [self PUT:path parameters:@{@"done": @(done)} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (completion)
            completion(nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (completion)
            completion(error);
    }];
}

@end
