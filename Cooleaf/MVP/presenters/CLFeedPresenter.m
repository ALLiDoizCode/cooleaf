//
//  CLFeedPresenter.m
//  Cooleaf
//
//  Created by Haider Khan on 9/18/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "CLFeedPresenter.h"
#import "CLBus.h"

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

@end
