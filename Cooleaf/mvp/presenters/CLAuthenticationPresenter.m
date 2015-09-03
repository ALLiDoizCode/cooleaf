//
//  CLAuthenticationPresenter.m
//  Cooleaf
//
//  Created by Haider Khan on 8/25/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "CLAuthenticationPresenter.h"

@implementation CLAuthenticationPresenter {
    
@private
    id <IAuthenticationInteractor> _authInfo;
}


# pragma initWithInteractor

- (id)initWithInteractor:(id<IAuthenticationInteractor>)interactor {
    _authInfo = interactor;
    return self;
}


# pragma registerOnBus

- (void)registerOnBus {
    REGISTER();
}


# pragma unregisterOnBus

- (void)unregisterOnBus {
    UNREGISTER();
}


#pragma authenticate

- (void)authenticate:(NSString *)email :(NSString *)password {
    CLAuthenticationEvent *authenticationEvent = [[CLAuthenticationEvent alloc] initWithCredentials:email :password];
    PUBLISH(authenticationEvent);
}


# pragma onAuthenticationSuccessEvent

SUBSCRIBE(CLAuthenticationSuccessEvent) {
    [_authInfo initUser:event.user];
}


# pragma dealloc

- (void)dealloc {
    [self unregisterOnBus];
}


@end
