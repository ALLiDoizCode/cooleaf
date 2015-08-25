//
//  CLAddress.h
//  Cooleaf
//
//  Created by Haider Khan on 8/24/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import <Mantle.h>

@interface CLAddress : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSString *addressLine1;
@property (nonatomic, copy) NSString *addressLine2;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *state;
@property (nonatomic, copy) NSString *zipcode;
@property (nonatomic, copy) NSString *name;

@end
