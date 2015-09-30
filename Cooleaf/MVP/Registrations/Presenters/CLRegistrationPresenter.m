//
//  CLRegistrationPresenter.m
//  Cooleaf
//
//  Created by Haider Khan on 9/29/15.
//  Copyright © 2015 Nova Project. All rights reserved.
//

#import "CLRegistrationPresenter.h"
#import "CLBus.h"
#import "CLCheckRegistrationEvent.h"
#import "CLFailedRegistrationEvent.h"

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

# pragma mark - checkRegistrationWithEmail

- (void)checkRegistrationWithEmail:(NSString *)email {
    PUBLISH([[CLCheckRegistrationEvent alloc] initWithEmail:email]);
}

# pragma mark - Subscription Methods

SUBSCRIBE(CLFailedRegistrationEvent) {
    [_registrationInfo registrationFailed];
}

@end
