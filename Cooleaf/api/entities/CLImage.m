//
//  CLImage.m
//  Cooleaf
//
//  Created by Haider Khan on 8/24/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "CLImage.h"

@implementation CLImage

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    return @{
      @"url": @"url",
      @"path": @"path"
      };
}
//
//# pragma urlSchemeJSONTransformer
//
//+ (NSValueTransformer *)urlSchemeJSONTransformer {
//    // use Mantle's built-in "value transformer" to convert strings to NSURL and vice-versa
//    // you can write your own transformers
//    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
//}
//
//# pragma pathSchemeJSONTransformer
//
//+ (NSValueTransformer *)pathSchemeJSONTransformer {
//    // use Mantle's built-in "value transformer" to convert strings to NSURL and vice-versa
//    // you can write your own transformers
//    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
//}

@end
