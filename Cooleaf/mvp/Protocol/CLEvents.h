//
//  CLEvents.h
//  Cooleaf
//
//  Created by Jonathan Green on 8/26/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//


@protocol EventInfo <NSObject>

- (void)setEventId:(NSUInteger *) objectId;
- (void)setEventName:(NSString *) name;
- (void)setEventParticipants:(NSDictionary *)eventParticipants;
- (void)setEventStartTime:(NSString *)eventStartTime;
- (void)setEventRewardPoints:(int)eventRewardPoints;
- (void)setIsAttending:(BOOL)isAttending;
- (void)setIsJoinable:(BOOL)isJoinable;

@end