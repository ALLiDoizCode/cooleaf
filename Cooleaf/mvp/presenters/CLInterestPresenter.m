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

@interface CLInterestPresenter()
@end

@implementation CLInterestPresenter

# pragma mark - Init

- (id)initWithInteractor:(id<IInterestInteractor>)interactor {
    _interestInfo = interactor;
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

# pragma mark - Subscription Events

SUBSCRIBE(CLLoadedInterests) {
    [_interestInfo initInterests:event.interests];
}

@end
