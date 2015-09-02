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
    [[CLClient getInstance] POST:@"authorize.json" parameters:params completion:^(id response, NSError *error) {
        if (!error) {
            success(response);
        } else {
            failure(error);
        }
    }];
}

# pragma deauthenticate



@end
