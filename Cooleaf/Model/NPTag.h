//
//  NPTag.h
//  Cooleaf
//
//  Created by Curtis Jones on 2015.03.09.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NPTag : NSObject

@property (readwrite, assign, nonatomic) NSUInteger objectId;
@property (readwrite, assign, nonatomic) BOOL isDefault;
@property (readwrite, assign, nonatomic) BOOL isActive;
@property (readwrite, retain, nonatomic) NSString *name;
@property (readwrite, assign, nonatomic) NSUInteger parentId;
@property (readwrite, retain, nonatomic) NSString *parentType;
@property (readwrite, retain, nonatomic) NSString *type;

/**
 * {
 *   active = 1;
 *   default = 0;
 *   id = 26;
 *   name = "North Decatur";
 *   "parent_id" = 11;
 *   "parent_type" = Structure;
 *   type = structure;
 * }
 *
 */
- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
