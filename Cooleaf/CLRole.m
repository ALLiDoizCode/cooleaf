//
//  NPRole.m
//  Cooleaf
//
//  Created by Haider Khan on 8/24/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "CLRole.h"

@implementation CLRole

# pragma MTLJSONSerialization

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"isActive": @"active",
             @"rights": @"rights",
             @"organization": @"organization",
             @"branch": @"branch",
             @"department": @"department",
             @"structureTags": @"structure_tags",
             @"structures": @"structures"
             };
}

@end
