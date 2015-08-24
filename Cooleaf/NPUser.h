//
//  NPUser.h
//  Cooleaf
//
//  Created by Haider Khan on 8/24/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import <Mantle.h>
#import "NPRole.h"
#import "NPProfile.h"
#import "NPPicture.h"

@interface NPUser : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy, readonly) NSNumber *userId;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *userEmail;
@property (nonatomic, copy) NSMutableArray *interests;
@property (nonatomic, copy) NPRole *role;
@property (nonatomic, copy) NSNumber *rewardPoints;
@property (nonatomic, copy) NPProfile *profile;

@end
