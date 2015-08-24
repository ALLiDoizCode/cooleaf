//
//  NPTag.h
//  Cooleaf
//
//  Created by Haider Khan on 8/24/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import <Mantle.h>

@interface NPTag : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy, readonly) NSNumber *tagId;
@property (nonatomic, copy) NSString *tagName;
@property (nonatomic, copy) NSString *tagType;
@property (nonatomic) BOOL *isActive;
@property (nonatomic, copy) NSNumber *parentId;
@property (nonatomic) BOOL *isDefault;

@end
