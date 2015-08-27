//
//  CLEventPresenter.m
//  Cooleaf
//
//  Created by Haider Khan on 8/25/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "CLEventPresenter.h"

@implementation CLEventPresenter {

@private
    id <EventInfo> _eventInfo;

}

@synthesize eventInfo = _eventInfo;


- (CLEventPresenter *)initWithAddUserInfo:(id <EventInfo>)eventInfo {
    
    if (self = [super init]) {
        
        _eventInfo = eventInfo;
    }
    
    return self;
}


-(void)loadEvents {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"loadEvents" object:nil userInfo:nil];
}


///Protocols
#pragma setEventId

- (void)setEventId:(NSUInteger *) objectId {
    
}

#pragma setEventName

- (void)setEventName:(NSString *) name {
    
}

#pragma setEventParticipants

- (void)setEventParticipants:(NSDictionary *)eventParticipants {
    
    
}

#pragma setEventStartTime

- (void)setEventStartTime:(NSString *)eventStartTime {
    
    
}

#pragma setEventRewardPoints

- (void)setEventRewardPoints:(int)eventRewardPoints {
    
    
}

#pragma setIsAttending

- (void)setIsAttending:(BOOL)isAttending {
    
    
}

#pragma setIsJoinable

- (void)setIsJoinable:(BOOL)isJoinable {
    
    
}

@end
