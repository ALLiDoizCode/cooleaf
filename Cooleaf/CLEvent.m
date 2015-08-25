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


# pragma addressJSONTransformer

- (NSValueTransformer *)addressJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSDictionary *addressDict) {
        return [MTLJSONAdapter  modelOfClass:CLAddress.class
                                fromJSONDictionary:addressDict
                                error:nil];
    } reverseBlock:^(CLAddress *address) {
        return [MTLJSONAdapter JSONDictionaryFromModel:address];
    }];
}


# pragma urlSchemeJSONTransformer

+ (NSValueTransformer *)urlSchemeJSONTransformer {
    // use Mantle's built-in "value transformer" to convert strings to NSURL and vice-versa
    // you can write your own transformers
    return [NSValueTransformer valueTransformerForName:MTLURLValueTransformerName];
}


# pragma imageJSONTransformer

- (NSValueTransformer *)imageJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSDictionary *imageDict) {
        return [MTLJSONAdapter  modelOfClass:CLImage.class
                          fromJSONDictionary:imageDict
                                       error:nil];
    } reverseBlock:^(CLImage *image) {
        return [MTLJSONAdapter JSONDictionaryFromModel:image];
    }];
}


# pragma timeZoneJSONTransformer

- (NSValueTransformer *)timeZoneJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSDictionary *timeZoneDict) {
        return [MTLJSONAdapter  modelOfClass:CLTimeZone.class
                          fromJSONDictionary:timeZoneDict
                                       error:nil];
    } reverseBlock:^(CLTimeZone *timeZone) {
        return [MTLJSONAdapter JSONDictionaryFromModel:timeZone];
    }];
}


# pragma seriesJSONTransformer

- (NSValueTransformer *)seriesJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSDictionary *seriesDict) {
        return [MTLJSONAdapter  modelOfClass:CLSeries.class
                          fromJSONDictionary:seriesDict
                                       error:nil];
    } reverseBlock:^(CLSeries *series) {
        return [MTLJSONAdapter JSONDictionaryFromModel:series];
    }];
}


# pragma coodinatorJSONTransformer

- (NSValueTransformer *)coordinatorJSONTransformer {
    return [MTLValueTransformer reversibleTransformerWithForwardBlock:^(NSDictionary *coorDict) {
        return [MTLJSONAdapter  modelOfClass:CLCoordinator.class
                          fromJSONDictionary:coorDict
                                       error:nil];
    } reverseBlock:^(CLCoordinator *coor) {
        return [MTLJSONAdapter JSONDictionaryFromModel:coor];
    }];
}

@end
