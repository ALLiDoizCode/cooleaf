//
//  CLEventController.m
//  Cooleaf
//
//  Created by Haider Khan on 8/25/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "CLEventController.h"

static NSString *const kOngoingEventsPath = @"events/ongoing.json";
static NSString *const kUserEventsPath = @"events/user/";

@implementation CLEventController

# pragma getEvents

- (void)getEvents:(NSMutableDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *error))failure {
    [[CLClient getInstance] GET:kOngoingEventsPath parameters:nil completion:^(id response, NSError *error) {
        if (!error) {
            success(response);
        } else {
            failure(error);
        }
    }];
}

- (void)getUserEventsWithScope:(NSString *)userId params:(NSMutableDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    NSString *path = [NSString stringWithFormat:@"%@%@%@", kUserEventsPath, userId, @".json"];
    [[CLClient getInstance] GET:path parameters:params completion:^(id response, NSError *error) {
       if (!error)
           success(response);
       else
           failure(error);
    }];
}

@end
