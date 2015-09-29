//
//  CLUserController.m
//  Cooleaf
//
//  Created by Haider Khan on 8/25/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "CLUserController.h"
#import "CLCLient.h"

static NSString *const kUsersPath = @"v2/users.json";

@implementation CLUserController

- (void)getMe:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    [CLClient setOrganizationHeader:[[NSUserDefaults standardUserDefaults] objectForKey:@"X-Organization"]];
    [[CLClient getInstance] loadCookies];
    [[CLClient getInstance] GET:@"v2/users/me.json" parameters:params completion:^(id response, NSError *error) {
        if (!error)
            success(response);
        else
            failure(error);
    }];
}

- (void)getUsers:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    [[CLClient getInstance] GET:kUsersPath parameters:params completion:^(id response, NSError *error) {
        if (!error)
            success(response);
        else
            failure(error);
    }];
}

@end
