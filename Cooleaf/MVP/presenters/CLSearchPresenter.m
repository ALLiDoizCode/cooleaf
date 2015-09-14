//
//  CLSearchPresenter.m
//  Cooleaf
//
//  Created by Haider Khan on 9/14/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "CLSearchPresenter.h"
#import "CLBus.h"
#import "CLLoadQueryEvent.h"

static NSInteger const PAGE = 1;
static NSInteger const PER_PAGE = 25;

@implementation CLSearchPresenter

# pragma mark - Init

- (id)initWithInteractor:(id<ISearchInteractor>)interactor {
    _searchInfo = interactor;
    return self;
}

# pragma mark - Bus Methods

- (void)registerOnBus {
    REGISTER();
}

- (void)unregisterOnBus {
    UNREGISTER();
}

# pragma mark - loadQuery

- (void)loadQuery:(NSString *)query {
    CLLoadQueryEvent *loadQuery = [[CLLoadQueryEvent alloc] initWithQuery:query scope:nil page:PAGE perPage:PER_PAGE];
    PUBLISH(loadQuery);
}

@end
