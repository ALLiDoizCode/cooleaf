//
//  NPTagGroup.h
//  Cooleaf
//
//  Created by Curtis Jones on 2015.03.09.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NPTagGroup : NSObject

@property (readonly, assign, nonatomic) NSUInteger objectId;
@property (readonly, retain, nonatomic) NSString *name;
@property (readonly, assign, nonatomic) BOOL isPrimary;
@property (readonly, assign, nonatomic) BOOL isRequired;
@property (readonly, retain, nonatomic) NSArray *tags;

/**
 * {
 *   id = 11;
 *   name = Location;
 *   primary = 1;
 *   required = 1;
 *   tags = [ ... ]
 * }
 *
 */
- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
