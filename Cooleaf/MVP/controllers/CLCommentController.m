//
//  CLCommentController.m
//  Cooleaf
//
//  Created by Haider Khan on 9/20/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "CLCommentController.h"
#import "CLClient.h"

static NSString *const kCommentsPath = @"v2/comments/";
static NSString *const kCommentsEventPath = @"v2/comments/Event/";

@implementation CLCommentController

- (void)getEventComments:(NSInteger)eventId params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    NSString *path = [NSString stringWithFormat:@"%@%d%@", kCommentsEventPath, (int) eventId, @".json"];
    [[CLClient getInstance] GET:path parameters:params completion:^(id response, NSError *error) {
        if (!error)
            success(response);
        else
            failure(error);
    }];
}

- (void)addEventComment:(NSInteger)eventId params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    NSString *path = [NSString stringWithFormat:@"%@%d%@", kCommentsEventPath, (int) eventId, @".json"];
    [[CLClient getInstance] POST:path parameters:params completion:^(id response, NSError *error) {
        if (!error)
            success(response);
        else
            failure(error);
    }];
}

- (void)deleteEventComment:(NSInteger)eventId comment:(NSInteger)commentId params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    NSString *path = [NSString stringWithFormat:@"%@%d%d%@", kCommentsEventPath, (int) eventId, (int)commentId, @".json"];
    [[CLClient getInstance] DELETE:path parameters:params completion:^(id response, NSError *error) {
       if (!error)
           success(response);
        else
            failure(error);
    }];
}

@end
