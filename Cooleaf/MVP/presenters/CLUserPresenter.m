//
//  CLUserPresenter.m
//  Cooleaf
//
//  Created by Haider Khan on 9/15/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "CLUserPresenter.h"
#import "CLBus.h"
#import "CLLoadUsersEvent.h"
#import "CLLoadedUsersEvent.h"
#import "CLLoadMeEvent.h"
#import "CLLoadedMeEvent.h"

static NSInteger const PAGE = 1;
static NSInteger const PER_PAGE = 25;

@implementation CLUserPresenter

# pragma mark - Init

- (id)initWithInteractor:(id<IUserInteractor>)interactor {
    _userInfo = interactor;
    return self;
}

# pragma mark - Bus Methods

- (void)registerOnBus {
    REGISTER();
}

- (void)unregisterOnBus {
    UNREGISTER();
}

# pragma mark - loadMe

- (void)loadMe {
    PUBLISH([[CLLoadMeEvent alloc] init]);
}

# pragma mark - loadOrganizationUsers

- (void)loadOrganizationUsers {
    CLLoadUsersEvent *loadUsersEvent = [[CLLoadUsersEvent alloc] initWithPage:PAGE perPage:PER_PAGE];
    PUBLISH(loadUsersEvent);
}

# pragma mark - Subscription Methods

SUBSCRIBE(CLLoadedUsersEvent) {
    [_userInfo initOrganizationUsers:event.users];
}

SUBSCRIBE(CLLoadedMeEvent) {
    [_userInfo initMe:event.user];
}

@end
