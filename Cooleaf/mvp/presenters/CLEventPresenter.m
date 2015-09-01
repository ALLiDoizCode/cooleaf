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
    PUBLISH([[CLLoadEvents alloc] init]);
}


# pragma Subscription Methods

SUBSCRIBE(CLLoadedEvents) {
    NSLog(@"CLLoadedEvents");
    [_eventInfo initEvents:event.events];
}


# pragma dealloc

- (void)dealloc {
    [self unregisterOnBus];
}


@end
