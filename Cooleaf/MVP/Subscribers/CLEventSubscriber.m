//
//  CLEventSubscriber.m
//  Cooleaf
//
//  Created by Haider Khan on 8/26/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "CLEventSubscriber.h"
#import "CLLoadUserEvents.h"
#import "CLLoadedEvents.h"
#import "CLLoadEvents.h"
#import "CLLoadedUserEvents.h"
#import "CLLoadJoinEvent.h"
#import "CLLoadedJoinEvent.h"
#import "CLLoadLeaveEvent.h"
#import "CLLoadedLeaveEvent.h"

@interface CLEventSubscriber() {
    @private
    CLEventController *_eventController;
}

@end

@implementation CLEventSubscriber

# pragma init

- (id)init {
    _eventController = [[CLEventController alloc] init];
    return self;
}


# pragma subscription events

SUBSCRIBE(CLLoadEvents) {
    [_eventController getEvents:nil success:^(id response) {
        NSMutableArray *events = [response result];
        CLLoadedEvents *loadedEvents = [[CLLoadedEvents alloc] initWithEvents:events];
        PUBLISH(loadedEvents);
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}

SUBSCRIBE(CLLoadUserEvents) {
    NSDictionary *params = @{
                            @"page": [NSString stringWithFormat:@"%lu", (long) event.page],
                            @"per_page": [NSString stringWithFormat:@"%lu", (long) event.perPage],
                            @"scope": event.scope
                            };
    
    [_eventController getUserEventsWithScope:event.userIdString
                                      params:params
                                     success:^(id JSON) {
                                         NSMutableArray *events = [JSON result];
                                         CLLoadedUserEvents *loadedEvents = [[CLLoadedUserEvents alloc] initWithUserEvents:events];
                                         PUBLISH(loadedEvents);
                                     } failure:^(NSError *error) {
                                         NSLog(@"%@", error);
                                     }];
}

SUBSCRIBE(CLLoadJoinEvent) {
    // Get event id
    NSInteger eventId = event.eventId;
    [_eventController joinEventWithId:eventId params:nil success:^(id JSON) {
        PUBLISH([[CLLoadedJoinEvent alloc] init]);
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}

SUBSCRIBE(CLLoadLeaveEvent) {
    // Get event id
    NSInteger eventId = event.eventId;
    [_eventController joinEventWithId:eventId params:nil success:^(id JSON) {
        PUBLISH([[CLLoadedLeaveEvent alloc] init]);
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}

@end