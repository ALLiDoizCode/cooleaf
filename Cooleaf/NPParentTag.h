//
//  NPParentTag.h
//  Cooleaf
//
//  Created by Haider Khan on 8/24/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import <Mantle.h>

@interface NPParentTag : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy, readonly) NSNumber *parentTagId;
@property (nonatomic, copy) NSString *parentTagName;
@property (nonatomic, copy) NSMutableArray *tags;
@property (nonatomic) BOOL *isRequired;
@property (nonatomic) BOOL *isPrimary;

@end
