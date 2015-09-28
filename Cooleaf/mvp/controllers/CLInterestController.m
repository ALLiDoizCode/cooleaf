//
//  CLInterestController.m
//  Cooleaf
//
//  Created by Haider Khan on 8/25/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "CLInterestController.h"
#import "CLClient.h"

static NSString *const kInterestsPath = @"v2/interests.json";
static NSString *const kInterestPartialPath = @"v2/interests/";

@implementation CLInterestController

- (void)getInterests:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    [[CLClient getInstance] GET:kInterestsPath parameters:params completion:^(id response, NSError *error) {
        if (!error)
            success(response);
        else
            failure(error);
    }];
}

- (void)getInterestMembers:(NSInteger)interestId params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    // Members path url
    NSString *membersPath = [NSString stringWithFormat:@"%@%d%@", kInterestPartialPath, (int) interestId, @"/memberlist.json"];
    [[CLClient getInstance] GET:membersPath parameters:params completion:^(id response, NSError *error) {
        if (!error)
            success(response);
        else
            failure(error);
    }];
}

- (void)joinInterest:(NSInteger)interestId params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    NSString *joinPath = [NSString stringWithFormat:@"%@%d%@", kInterestPartialPath, (int) interestId, @"/join.json"];
    
    [[CLClient getInstance] POST:joinPath parameters:params success:^(AFHTTPRequestOperation *operation, id response) {
        success(response);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // Valid JSON is not returned therefore it throws an error, however status code is 200
        NSInteger statusCode = [[operation response] statusCode];
        if (statusCode == 200) {
            success(operation);
        } else {
            // Something else went wrong with network
            NSLog(@"%@", error);
            failure(error);
        }

    }];
}

- (void)leaveInterest:(NSInteger)interestId params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    NSString *leavePath = [NSString stringWithFormat:@"%@%d%@", kInterestPartialPath, (int) interestId, @"/join.json"];
    NSLog(@"%@", leavePath);
    [[CLClient getInstance] DELETE:leavePath parameters:params completion:^(id response, NSError *error) {
        NSLog(@"%@", response);
        if (!error)
            success(response);
        else
            failure(error);
    }];
}

@end
