//
//  NPOrganization.m
//  Cooleaf
//
//  Created by Haider Khan on 8/24/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "CLOrganization.h"

@implementation CLOrganization

# pragma MTLJSONSeriliazation

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
             @"organizationId": @"id",
             @"organizationName": @"name",
             @"organizationSubdomain": @"subdomain",
             @"organizationPicture": @"logo",
             @"structures": @"structures"
             };
}

# pragma pictureJSONTransformer

- (NSValueTransformer *)pictureJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSDictionary *pictureDict) {
        return [MTLJSONAdapter  modelOfClass:CLPicture.class
                                fromJSONDictionary:pictureDict
                                error:nil];
    } reverseBlock:^(CLPicture *picture) {
        return [MTLJSONAdapter  JSONDictionaryFromModel:picture];
    }];
}

# pragma Custom JSONTransformer for parsing structures here

//+ (NSValueTransformer *)structureJSONTransformer {
//    Need to still write code for custom transformer here
//}

@end
