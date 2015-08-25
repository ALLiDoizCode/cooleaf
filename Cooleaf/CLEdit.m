//
//  CLEdit.m
//  Cooleaf
//
//  Created by Haider Khan on 8/24/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "CLEdit.h"

@implementation CLEdit

# pragma MTLJSONSerialization

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"categoryIds": @"category_ids",
             @"email": @"email",
             @"fileCache": @"file_cache",
             @"editId": @"id",
             @"name": @"name",
             @"profile": @"profile",
             @"removePicture": @"removed_picture",
             @"rewardPoints": @"reward_points",
             @"role": @"role"
             };
}

@end
