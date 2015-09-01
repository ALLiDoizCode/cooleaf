//
//  CLEventController.m
//  Cooleaf
//
//  Created by Haider Khan on 8/25/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "CLEventController.h"

@implementation CLEventController


# pragma getEvents

- (void)getEvents:(NSMutableDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *error))failure {
    NSString *path = @"/events/ongoing.json";
    [[CLClient getInstance] GET:path parameters:params completion:^(id response, NSError *error) {
        if (success) {
            success(success);
        } else if (failure) {
            failure(error);
        }
    }];
}

@end
