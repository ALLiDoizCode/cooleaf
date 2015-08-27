//
//  CLAuthenticationSubscriber.m
//  Cooleaf
//
//  Created by Haider Khan on 8/26/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "CLAuthenticationSubscriber.h"

@interface CLAuthenticationSubscriber() {
    @private
    CLAuthenticationController *authenticationController;
}

@end

@implementation CLAuthenticationSubscriber

# pragma init

- (id)init {
    authenticationController = [[CLAuthenticationController alloc] init];
    return self;
}


# pragma authenticateEvent

SUBSCRIBE(CLAuthenticationEvent) {
    [authenticationController authenticate:event.email :event.password];
}


# pragma authenticationSuccessfulEvent

SUBSCRIBE(CLAuthenticationSuccessEvent) {
    
}

@end