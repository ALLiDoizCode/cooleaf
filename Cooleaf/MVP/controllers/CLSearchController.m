//
//  CLSearchController.m
//  Cooleaf
//
//  Created by Haider Khan on 9/14/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "CLSearchController.h"
#import "CLClient.h"

static NSString *const kSearchPath = @"search.json";

@implementation CLSearchController

- (void)executeQuery:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    [[CLClient getInstance] GET:kSearchPath parameters:nil completion:^(id response, NSError *error) {
        if (!error) {
            success(response);
        } else {
            failure(error);
        }
    }];
}

@end
