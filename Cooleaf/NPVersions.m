//
//  NPVersions.m
//  Cooleaf
//
//  Created by Haider Khan on 8/24/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "NPVersions.h"

@implementation NPVersions

# pragma MTLJSONSerialization

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"thumbUrl": @"thumb",
             @"iconUrl": @"icon",
             @"smallUrl": @"small",
             @"mediumUrl": @"medium",
             @"largeUrl": @"large",
             @"bigUrl": @"big",
             @"mainUrl": @"main",
             @"coverUrl": @"cover"
             };
}

@end
