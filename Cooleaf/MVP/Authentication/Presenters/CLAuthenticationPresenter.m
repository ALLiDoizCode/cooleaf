//
//  CLAuthenticationPresenter.m
//  Cooleaf
//
//  Created by Haider Khan on 8/25/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "CLAuthenticationPresenter.h"
#import "CLDeAuthorizeEvent.h"
#import "CLDeAuthorizedEvent.h"
#import "CLAuthenticationFailedEvent.h"
#import "CLAuthenticateNewUserEvent.h"
#import "CLAuthenticatedNewUserEvent.h"

@interface CLAuthenticationPresenter()

@property (weak) id<IAuthenticationInteractor> authInfo;

@end

@implementation CLAuthenticationPresenter

# pragma mark - initWithInteractor

- (id)initWithInteractor:(id<IAuthenticationInteractor>)interactor {
    _authInfo = interactor;
    return self;
}

# pragma mark - registerOnBus

- (void)registerOnBus {
    REGISTER();
}

# pragma mark - unregisterOnBus

- (void)unregisterOnBus {
    UNREGISTER();
}

# pragma mark - authenticate

- (void)authenticate:(NSString *)email :(NSString *)password {
    CLAuthenticationEvent *authenticationEvent = [[CLAuthenticationEvent alloc] initWithCredentials:email :password];
    PUBLISH(authenticationEvent);
}

# pragma mark - authenticateNewUser

- (void)authenticateNewUser:(NSString *)email password:(NSString *)password {
    CLAuthenticateNewUserEvent *authNewUserEvent = [[CLAuthenticateNewUserEvent alloc] initWithEmail:email password:password];
    PUBLISH(authNewUserEvent);
}

# pragma mark - deauthenticate

- (void)deauthenticate {
    PUBLISH([[CLDeAuthorizeEvent alloc] init]);
}

# pragma mark - Subscription Methods

SUBSCRIBE(CLAuthenticationSuccessEvent) {
    [_authInfo initUser:event.user];
}

SUBSCRIBE(CLAuthenticationFailedEvent) {
    [_authInfo authenticationFailed];
}

SUBSCRIBE(CLDeAuthorizedEvent) {
    [_authInfo deAuthorized];
}

SUBSCRIBE(CLAuthenticatedNewUserEvent) {
    [_authInfo newUserAuthenticated:event.user];
}

# pragma dealloc

- (void)dealloc {
    [self unregisterOnBus];
}

@end
