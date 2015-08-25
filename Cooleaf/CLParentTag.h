//
//  NPParentTag.h
//  Cooleaf
//
//  Created by Haider Khan on 8/24/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import <Mantle.h>
#import "CLTag.h"

@interface CLParentTag : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy, readonly) NSNumber *parentTagId;
@property (nonatomic, copy) NSString *parentTagName;
@property (nonatomic, copy) NSMutableArray *tags;
@property (nonatomic, assign) BOOL *isRequired;
@property (nonatomic, assign) BOOL *isPrimary;

@end
