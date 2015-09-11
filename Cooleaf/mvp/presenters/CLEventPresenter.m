//
//  CLEventPresenter.m
//  Cooleaf
//
//  Created by Haider Khan on 8/25/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "CLEventPresenter.h"
#import "CLBus.h"
#import "CLLoadEvents.h"
#import "CLLoadedEvents.h"
#import "CLLoadUserEvents.h"
#import "CLLoadedUserEvents.h"

static NSInteger const PAGE = 1;
static NSInteger const PER_PAGE = 25;

@interface CLEventPresenter()
@end

@implementation CLEventPresenter

# pragma mark - Init

// TODO - Check initialization of protocols when switching between profile and home
- (id)initWithInteractor:(id<IEventInteractor>)interactor {
    _eventInfo = interactor;
    return self;
}

# pragma mark - Bus Methods

- (void)registerOnBus {
    REGISTER();
}

- (void)unregisterOnBus {
    UNREGISTER();
}

# pragma mark - loadEvents

/**
 *  Load events, with no scope
 */
- (void)loadEvents {
    PUBLISH([[CLLoadEvents alloc] init]);
}

- (void)loadUserEvents:(NSString *)scope userIdString:(NSString *)userIdString {
    PUBLISH([[CLLoadUserEvents alloc] initWithUserId:userIdString page:PAGE perPage:PER_PAGE scope:scope]);
}

# pragma mark - Subscription Methods

SUBSCRIBE(CLLoadedEvents) {
    if (_eventInfo != nil)
        [_eventInfo initEvents:event.events];
}

SUBSCRIBE(CLLoadedUserEvents) {
    NSLog(@"CLLoadedUserEvents");
    if (_eventInfo != nil)
        [_eventInfo initUserEvents:event.events];
}

@end
