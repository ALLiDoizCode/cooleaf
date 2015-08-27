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

@property (nonatomic, readonly) NSNumber *eventId;
@property (nonatomic) CLAddress *address;
@property (nonatomic) NSString *eventDescription;
@property (nonatomic) NSString *name;
@property (nonatomic) NSString *imageUrl;
@property (nonatomic) CLImage *eventImage;
@property (nonatomic) NSMutableArray *eventParticipants;
@property (nonatomic) NSNumber *participantsCount;
@property (nonatomic, readonly) CLTimeZone *timeZone;
@property (nonatomic) NSString *startTime;
@property (nonatomic) NSString *lastStartTime;
@property (nonatomic) NSString *endTime;
@property (nonatomic) NSNumber *rewardPoints;
@property (nonatomic) BOOL *isPast;
@property (nonatomic) BOOL *isJoinable;
@property (nonatomic) BOOL *isAttending;
@property (nonatomic) BOOL *isPaid;
@property (nonatomic) CLSeries *eventSeries;
@property (nonatomic) CLCoordinator *coordinator;
@property (nonatomic) NSString *coordinatorName;

@end