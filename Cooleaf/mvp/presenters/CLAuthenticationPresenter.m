//
//  CLAuthenticationPresenter.m
//  Cooleaf
//
//  Created by Haider Khan on 8/25/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "CLAuthenticationPresenter.h"

@implementation CLAuthenticationPresenter


#pragma authenticate

- (void)authenticate:(NSString *)email :(NSString *)password {
    
}


# pragma showAuthenticationError

- (void)showAuthenticationError {
    
}


# pragma addSelfAsObserver

- (void)addSelfAsObserver {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                          selector:@selector(authenticate::)
                                          name:@"authenticateEvent"
                                          object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                          selector:@selector(showAuthenticationError)
                                          name:@"errorAuthentication"
                                          object:nil];
}


# pragma removeSelfAsObserver

- (void)removeSelfAsObserver {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
