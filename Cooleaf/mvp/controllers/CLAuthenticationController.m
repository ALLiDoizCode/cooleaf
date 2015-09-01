//
//  CLAuthenticationController.m
//  Cooleaf
//
//  Created by Haider Khan on 8/25/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "CLAuthenticationController.h"

@implementation CLAuthenticationController


# pragma authenticate

- (void)authenticate:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    NSLog(@"CLAuthenticationController");
    [[CLClient getInstance] POST:@"authorize.json" parameters:params completion:^(id response, NSError *error) {
        if (!error) {
            success(response);
        } else {
            failure(error);
        }
    }];
}


# pragma authenticate

- (void)authenticate:(NSString *)email :(NSString *)password {
    
    NSDictionary *authDict = @{
                               @"email": email,
                               @"password": password
                               };
    
    // Do your network operation
    [[CLClient getInstance] POST:@"authorize.json" parameters:authDict completion:^(id response, NSError *error) {
        if (!error) {
            NSDictionary *userDictionary = [response result];
            CLUser *user = [MTLJSONAdapter modelOfClass:[CLUser class] fromJSONDictionary:userDictionary error:nil];
            NSLog(@"%@", user);
        } else {
            NSLog(@"Error: %@", [error userInfo]);
        }
    }];
    
}


# pragma deauthenticate



@end
