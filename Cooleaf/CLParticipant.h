//
//  CLParticipant.h
//  Cooleaf
//
//  Created by Haider Khan on 8/24/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import <Mantle.h>
#import "CLProfile.h"

@interface CLParticipant : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy, readonly) NSNumber *participantId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) CLProfile *profile;
@property (nonatomic, copy) NSString *pictureUrl;
@property (nonatomic, copy) NSMutableArray *primaryTagNames;

@end
