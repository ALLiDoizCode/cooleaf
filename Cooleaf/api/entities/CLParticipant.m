//
//  CLParticipant.m
//  Cooleaf
//
//  Created by Haider Khan on 8/24/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "CLParticipant.h"

@implementation CLParticipant

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"participantId": @"id",
             @"name": @"name",
             @"profile": @"profile",
             @"pictureUrl": @"picture_url",
             @"primaryTagNames": @"primary_tag_names"
             };
}


# pragma profileJSONTransformer

- (NSValueTransformer *)profileJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSDictionary *profileDict) {
        return [MTLJSONAdapter  modelOfClass:CLProfile.class
                          fromJSONDictionary:profileDict
                                       error:nil];
    } reverseBlock:^(CLProfile *profile) {
        return [MTLJSONAdapter JSONDictionaryFromModel:profile];
    }];
}


# pragma urlSchemeJSONTransformer

+ (NSValueTransformer *)urlSchemeJSONTransformer {
    // use Mantle's built-in "value transformer" to convert strings to NSURL and vice-versa
    // you can write your own transformers
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}


# pragma primaryTagNameJSONTransformer

- (NSValueTransformer *)primaryTagNameJSONTransformer {
    return [NSValueTransformer mtl_JSONArrayTransformerWithModelClass:NSString.class];
}


@end
