//
//  CLParticipantPresenter.m
//  Cooleaf
//
//  Created by Haider Khan on 9/22/15.
//  Copyright © 2015 Nova Project. All rights reserved.
//

#import "CLParticipantPresenter.h"
#import "CLBus.h"
#import "CLLoadEventParticipants.h"
#import "CLLoadedEventParticipants.h"

static NSInteger const PAGE = 1;
static NSInteger const PER_PAGE = 25;

@implementation CLParticipantPresenter

# pragma mark - Init

- (id)initWithInteractor:(id<IParticipantInteractor>)interactor {
    _participantInfo = interactor;
    return self;
}

# pragma mark - Bus Methods

- (void)registerOnBus {
    REGISTER();
}

- (void)unregisterOnBus {
    UNREGISTER();
}

# pragma mark - loadEventParticipants

- (void)loadEventParticipants:(NSInteger)eventId {
    PUBLISH([[CLLoadEventParticipants alloc] initWithEventId:eventId page:PAGE perPage:PER_PAGE]);
}

# pragma mark - Subscription Methods

SUBSCRIBE(CLLoadedEventParticipants) {
    if ([_participantInfo respondsToSelector:@selector(initParticipants:)])
        [_participantInfo initParticipants:event.participants];
}

@end
