//
//  CLEventController.m
//  Cooleaf
//
//  Created by Haider Khan on 8/25/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "CLEventController.h"

static NSString *const kEventsPath = @"v2/events/";
static NSString *const kOngoingEventsPath = @"v2/events/ongoing.json";
static NSString *const kUserEventsPath = @"v2/events/user/";

@implementation CLEventController

# pragma getEvents

- (void)getEvents:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *error))failure {
    [[CLClient getInstance] GET:kOngoingEventsPath parameters:nil completion:^(id response, NSError *error) {
        if (!error) {
            success(response);
        } else {
            failure(error);
        }
    }];
}

- (void)getUserEventsWithScope:(NSString *)userId params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    NSString *path = [NSString stringWithFormat:@"%@%@%@", kUserEventsPath, userId, @".json"];
    [[CLClient getInstance] GET:path parameters:params completion:^(id response, NSError *error) {
       if (!error)
           success(response);
       else
           failure(error);
    }];
}

- (void)joinEventWithId:(NSInteger)eventId params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    NSString *path = [NSString stringWithFormat:@"%@%d%@", kEventsPath, (int) eventId, @"/join.json"];
    [[CLClient getInstance] POST:path parameters:params completion:^(id response, NSError *error) {
        if (!error)
            success(response);
        else
            failure(error);
    }];
}

@end
