//
//  CLGroupPresenter.m
//  Cooleaf
//
//  Created by Haider Khan on 9/18/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "CLGroupPresenter.h"
#import "CLBus.h"

@implementation CLGroupPresenter

# pragma mark - Init

- (id)initWithInteractor:(id<IGroupInteractor>)interactor {
    _groupInfo = interactor;
    return self;
}

# pragma mark - Init Detail

- (id)initWithDetailInteractor:(id<IGroupDetailInteractor>)interactor {
    _groupDetailInfo = interactor;
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
