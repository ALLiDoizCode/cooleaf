//
//  NPBranch.m
//  Cooleaf
//
//  Created by Haider Khan on 8/24/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "NPBranch.h"

@implementation NPBranch

# pragma MTLJSONSerialization 

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"branchName": @"name",
             @"isDefault": @"default"
             };
}


@end
