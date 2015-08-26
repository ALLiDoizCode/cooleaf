//
//  CLInterest.m
//  Cooleaf
//
//  Created by Haider Khan on 8/24/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "CLInterest.h"

@implementation CLInterest

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"interestId": @"id",
             @"interestName": @"name",
             @"interestType": @"type",
             @"isActive": @"active",
             @"parentType": @"parent_type",
             @"image": @"image",
             @"userCount": @"users_count"
             };
}

+ (NSValueTransformer *)imageJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSDictionary *imageDict) {
        return [MTLJSONAdapter  modelOfClass:CLImage.class
                                fromJSONDictionary:imageDict
                                error:nil];
    } reverseBlock:^(CLImage *image) {
        return [MTLJSONAdapter JSONDictionaryFromModel:image];
    }];
}

@end
