//
//  CLRegistrationController.m
//  Cooleaf
//
//  Created by Haider Khan on 9/29/15.
//  Copyright © 2015 Nova Project. All rights reserved.
//

#import "CLRegistrationController.h"
#import "CLClient.h"

static NSString *const kRegistrationsCheckPath = @"v2/registrations/check.json";
static NSString *const kRegistrationsPath = @"v2/registrations.json";

@implementation CLRegistrationController

- (void)checkRegistrationWithParams:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    [[CLClient getInstance] POST:kRegistrationsCheckPath parameters:params completion:^(id response, NSError *error) {
        if (!error)
            success(response);
        else
            failure(error);
    }];
}

- (void)registerUserWithParams:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    [[CLClient getInstance] POST:kRegistrationsPath parameters:params completion:^(id response, NSError *error) {
        if (!error)
            success(response);
        else
            failure(error);
    }];
}

@end
