//
//  CLRegistrationPresenter.m
//  Cooleaf
//
//  Created by Haider Khan on 9/29/15.
//  Copyright © 2015 Nova Project. All rights reserved.
//

#import "CLRegistrationPresenter.h"
#import "CLBus.h"

@implementation CLRegistrationPresenter

# pragma mark - Init

- (id)initWithInteractor:(id<IRegistrationInteractor>)interactor {
    _registrationInfo = interactor;
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
