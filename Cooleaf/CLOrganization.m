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

@end
