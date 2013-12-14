//
//  NPCooleafClient.m
//  Cooleaf
//
//  Created by Bazyli Zygan on 14.12.2013.
//  Copyright (c) 2013 Nova Project. All rights reserved.
//

#import "NPCooleafClient.h"
#import <SSKeychain/SSKeychain.h>

@interface NPCooleafClient ()

@property (nonatomic, copy) NSString *apiPrefix;

@end

@implementation NPCooleafClient

static NSString * const kNPCooleafClientBaseURLString = @"http://cooleaf-staging.monterail.eu";
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
            _sharedClient.apiPrefix = kNPCooleafClientAPIPrefix;
//            _sharedClient.credential = [[NSURLCredential alloc] initWithUser:kNPCooleafClientAPIAuthLogin password:kNPCooleafClientAPIAuthPassword persistence:NSURLCredentialPersistencePermanent];
            AFHTTPRequestSerializer *reqSerializer = [AFHTTPRequestSerializer serializer];
            if (kNPCooleafClientAPIAuthLogin.length > 0)
                [reqSerializer setAuthorizationHeaderFieldWithUsername:kNPCooleafClientAPIAuthLogin password:kNPCooleafClientAPIAuthPassword];
            [reqSerializer setValue:@"coca-cola" forHTTPHeaderField:@"X-Organization"];
            _sharedClient.requestSerializer = reqSerializer;
            _sharedClient.responseSerializer = [AFJSONResponseSerializer serializer];
        });
    
    return _sharedClient;
}

- (void)loginWithUsername:(NSString *)username password:(NSString *)password  completion:(void(^)(NSError *error))completion
{
    NSString *path = @"/authorize.json";
    
    if (_apiPrefix.length > 0)
        path = [_apiPrefix stringByAppendingString:path];
    [self POST:path parameters:@{@"email": username, @"password": password} success:^(AFHTTPRequestOperation *operation, id responseObject) {
        _userData = [responseObject copy];
        
        [[NSUserDefaults standardUserDefaults] setObject:username forKey:@"username"];
//        [SSKeychain setPassword:password forService:@"cooleaf" account:username];
        if (completion)
            completion(nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (completion)
            completion(error);
    }];
}

@end
