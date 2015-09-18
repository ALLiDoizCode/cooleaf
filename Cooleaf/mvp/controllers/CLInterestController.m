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
static NSString *const kInterestMembersPath = @"v2/interests/";

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
    NSString *membersPath = [NSString stringWithFormat:@"%@%d%@", kInterestMembersPath, (int) interestId, @"/memberlist.json"];
    [[CLClient getInstance] GET:membersPath parameters:params completion:^(id response, NSError *error) {
        if (!error)
            success(response);
        else
            failure(error);
    }];
}

@end
