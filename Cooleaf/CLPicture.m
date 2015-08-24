//
//  NPPicture.m
//  Cooleaf
//
//  Created by Haider Khan on 8/24/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "CLPicture.h"

@implementation CLPicture

# pragma MTLJSONSerialization

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"originalUrl": @"original",
             @"versions": @"versions"
             };
}


@end
