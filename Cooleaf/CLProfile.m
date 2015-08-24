//
//  NPProfile.m
//  Cooleaf
//
//  Created by Haider Khan on 8/24/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "CLProfile.h"

@implementation CLProfile

# pragma MTLJSONSerialization

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"gender": @"gender",
             @"picture": @"picture",
             @"settings": @"settings"
             };
}

@end
