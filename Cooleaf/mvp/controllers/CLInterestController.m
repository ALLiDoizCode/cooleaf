//
//  CLInterestController.m
//  Cooleaf
//
//  Created by Haider Khan on 8/25/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "CLInterestController.h"
#import "CLClient.h"

static NSString *const kInterestsPath = @"interests.json";

@implementation CLInterestController

- (void)getInterests:(NSMutableDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    [[CLClient getInstance] GET:kInterestsPath parameters:params completion:^(id response, NSError *error) {
        if (!error)
            success(response);
        else
            failure(error);
    }];
}

@end
