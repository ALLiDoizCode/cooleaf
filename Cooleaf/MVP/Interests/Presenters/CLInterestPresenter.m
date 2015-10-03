//
//  CLInterestPresenter.m
//  Cooleaf
//
//  Created by Jonathan Green on 8/26/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "CLInterestPresenter.h"
#import "CLBus.h"
#import "CLLoadInterests.h"
#import "CLLoadedInterests.h"
#import "CLLoadInterestMembers.h"
#import "CLLoadedInterestMembers.h"
#import "CLLoadJoinInterest.h"
#import "CLLoadLeaveInterest.h"
#import "CLLoadedJoinInterest.h"
#import "CLLoadedLeaveInterest.h"

static NSInteger const PAGE = 1;
static NSInteger const PER_PAGE = 25;

@implementation CLInterestPresenter

# pragma mark - Init

- (id)initWithInteractor:(id<IInterestInteractor>)interactor {
    _interestInfo = interactor;
    return self;
}

# pragma mark - Init Detail

- (id)initWithDetailInteractor:(id<IInterestDetailInteractor>)interactor {
    _interestDetailInfo = interactor;
    return self;
}

# pragma mark - Bus Methods

- (void)registerOnBus {
    REGISTER();
}

- (void)unregisterOnBus {
    UNREGISTER();
}

# pragma mark - loadInterests

- (void)loadInterests {
    PUBLISH([[CLLoadInterests alloc] init]);
}

# pragma mark - loadInterestMembers

- (void)loadInterestMembers:(NSInteger)interestId {
    PUBLISH([[CLLoadInterestMembers alloc] initWithId:interestId page:PAGE perPage:PER_PAGE]);
}

# pragma mark - joinGroup

- (void)joinGroup:(NSInteger)interestId {
    PUBLISH([[CLLoadJoinInterest alloc] initWithInterestId:interestId]);
}

- (void)leaveGroup:(NSInteger)interestId {
    PUBLISH([[CLLoadLeaveInterest alloc] initWithInterestId:interestId]);

}

# pragma mark - Subscription Events

SUBSCRIBE(CLLoadedInterests) {
    if ([_interestInfo respondsToSelector:@selector(initInterests:)])
        [_interestInfo initInterests:event.interests];
}

SUBSCRIBE(CLLoadedInterestMembers) {
    if ([_interestInfo respondsToSelector:@selector(initMembers:)])
        [_interestDetailInfo initMembers:event.members];
}

SUBSCRIBE(CLLoadedJoinInterest) {
    if ([_interestInfo respondsToSelector:@selector(joinedInterest)])
        [_interestDetailInfo joinedInterest];
}

SUBSCRIBE(CLLoadedLeaveInterest) {
    if ([_interestInfo respondsToSelector:@selector(leaveInterest)])
        [_interestDetailInfo leaveInterest];
}

@end
