//
//  CLTimeZone.h
//  Cooleaf
//
//  Created by Haider Khan on 8/24/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import <Mantle.h>

@interface CLTimeZone : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *offset;
@property (nonatomic, copy) NSString *abbrv;
@property (nonatomic, copy) NSString *momentName;

@end
