//
//  CLCoordinator.h
//  Cooleaf
//
//  Created by Haider Khan on 8/24/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import <Mantle.h>
#import "CLProfile.h"

@interface CLCoordinator : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy, readonly) NSNumber *coordinatorId;
@property (nonatomic, assign) BOOL *isForeign;
@property (nonatomic, copy) NSString *coordinatorName;
@property (nonatomic, copy) NSString *coordinatorEmail;
@property (nonatomic, copy) CLProfile *coordinatorProfile;

@end
