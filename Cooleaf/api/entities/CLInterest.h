//
//  CLInterest.h
//  Cooleaf
//
//  Created by Haider Khan on 8/24/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import <Mantle.h>
#import "CLImage.h"

@interface CLInterest : MTLModel <MTLJSONSerializing>

@property (nonatomic, readonly) NSNumber *interestId;
@property (nonatomic) NSString *interestName;
@property (nonatomic) NSString *interestType;
@property (nonatomic, assign) BOOL isActive;
@property (nonatomic) NSString *parentType;
@property (nonatomic) CLImage *image;
@property (nonatomic) NSNumber *userCount;

@end
