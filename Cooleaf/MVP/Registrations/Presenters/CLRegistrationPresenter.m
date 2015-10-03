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
#import "CLCheckedRegistrationEvent.h"
#import "CLRegisterUserEvent.h"
#import "CLRegisteredUserEvent.h"

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

# pragma mark - registerUserWithToken

- (void)registerUserWithToken:(NSString *)token name:(NSString *)name password:(NSString *)password tags:(NSMutableArray *)tags {
    PUBLISH([[CLRegisterUserEvent alloc] initWithToken:token name:name password:password tags:tags]);
}

# pragma mark - Subscription Methods

SUBSCRIBE(CLCheckedRegistrationEvent) {
    if ([_registrationInfo respondsToSelector:@selector(registrationCheckSuccess:)])
        [_registrationInfo registrationCheckSuccess:event.registration];
}

SUBSCRIBE(CLFailedRegistrationEvent) {
    if ([_registrationInfo respondsToSelector:@selector(registrationCheckFailed)])
        [_registrationInfo registrationCheckFailed];
}

SUBSCRIBE(CLRegisteredUserEvent) {
    if ([_registrationInfo respondsToSelector:@selector(registeredUser:)])
        [_registrationInfo registeredUser:event.user];
}

@end
