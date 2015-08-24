//
//  NPUser.m
//  Cooleaf
//
//  Created by Haider Khan on 8/24/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "NPUser.h"

@implementation NPUser

# pragma MTLJSONSerialization

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"userId": @"id",
             @"userName": @"name",
             @"userEmail": @"email",
             @"interests": @"categories",
             @"role": @"role",
             @"rewardPoints": @"reward_points",
             @"profile": @"profile"
             };
}


@end
