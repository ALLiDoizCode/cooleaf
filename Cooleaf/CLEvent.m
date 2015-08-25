//
//  CLEvent.m
//  Cooleaf
//
//  Created by Haider Khan on 8/24/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "CLEvent.h"

@implementation CLEvent

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"eventId": @"id",
             @"address": @"address",
             @"eventDescription": @"description",
             
             };
}

@end
