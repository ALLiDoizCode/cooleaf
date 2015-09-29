//
//  CLFeedPresenter.m
//  Cooleaf
//
//  Created by Haider Khan on 9/18/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "CLFeedPresenter.h"
#import "CLBus.h"
#import "CLLoadInterestFeeds.h"
#import "CLLoadedInterestFeeds.h"

static NSInteger const PAGE = 1;
static NSInteger const PER_PAGE = 25;

@implementation CLFeedPresenter

# pragma mark - Init

- (id)initWithInteractor:(id<IFeedInteractor>)interactor {
    _feedInfo = interactor;
    return self;
}

# pragma mark - Bus Methods

- (void)registerOnBus {
    REGISTER();
}

- (void)unregisterOnBus {
    UNREGISTER();
}

# pragma mark - loadInterestFeeds

- (void)loadInterestFeeds:(NSInteger)interestId {
    PUBLISH([[CLLoadInterestFeeds alloc] initWithId:interestId page:PAGE perPage:PER_PAGE]);
}

# pragma mark - Subscription Methods

SUBSCRIBE(CLLoadedInterestFeeds) {
    [_feedInfo initFeeds:event.feeds];
}

@end
