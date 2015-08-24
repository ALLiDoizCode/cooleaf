//
//  NPPicture.m
//  Cooleaf
//
//  Created by Haider Khan on 8/24/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "NPPicture.h"

@implementation NPPicture

# pragma MTLJSONSerialization

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"originalUrl": @"original",
             @"versions": @"versions"
             };
}


@end
