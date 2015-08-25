//
//  CLEvent.h
//  Cooleaf
//
//  Created by Haider Khan on 8/24/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import <Mantle.h>
#import "CLAddress.h"
#import "CLImage.h"
#import "CLTimeZone.h"
#import "CLSeries.h"
#import "CLCoordinator.h"
#import "CLParticipant.h"

@interface CLEvent : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy, readonly) NSNumber *eventId;
@property (nonatomic, copy) CLAddress *address;
@property (nonatomic, copy) NSString *eventDescription;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *imageUrl;
@property (nonatomic, copy) CLImage *eventImage;
@property (nonatomic, copy) NSMutableArray *eventParticipants;
@property (nonatomic, copy) NSNumber *participantsCount;
@property (nonatomic, copy, readonly) CLTimeZone *timeZone;
@property (nonatomic, copy) NSString *startTime;
@property (nonatomic, copy) NSString *lastStartTime;
@property (nonatomic, copy) NSString *endTime;
@property (nonatomic, copy) NSNumber *rewardPoints;
@property (nonatomic, assign) BOOL *isPast;
@property (nonatomic, assign) BOOL *isJoinable;
@property (nonatomic, assign) BOOL *isAttending;
@property (nonatomic, assign) BOOL *isPaid;
@property (nonatomic, copy) CLSeries *eventSeries;
@property (nonatomic, copy) CLCoordinator *coordinator;
@property (nonatomic, copy) NSString *coordinatorName;

@end
