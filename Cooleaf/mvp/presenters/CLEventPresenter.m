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
    id <IEventInteractor> _eventInfo;
    
}


# pragma init

- (id)initWithInteractor:(id<IEventInteractor>)interactor {
    _eventInfo = interactor;
    return self;
}


# pragma registerOnBus

- (void)registerOnBus {
    REGISTER();
}


# pragma unregisterOnBus

- (void)unregisterOnBus {
    UNREGISTER();
}


# pragma loadEvents

- (void)loadEvents {
    CLLoadEvents *loadEvents = [[CLLoadEvents alloc] init];
    PUBLISH(loadEvents);
}


# pragma Subscription Methods

SUBSCRIBE(CLLoadedEvents) {
    NSMutableArray *events = event.events;
    [_eventInfo initEvents:events];
}

@end
