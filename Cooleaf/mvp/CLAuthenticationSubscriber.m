//
//  CLAuthenticationSubscriber.m
//  Cooleaf
//
//  Created by Haider Khan on 8/26/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "CLAuthenticationSubscriber.h"

@implementation CLAuthenticationSubscriber

# pragma init

- (id)init {
    _authenticationController = [[CLAuthenticationController alloc] init];
    return self;
}


# pragma authenticateEvent

SUBSCRIBE(CLAuthenticationEvent) {
    
    
    NSDictionary *authDict = @{
                               @"email": event.email,
                               @"password": event.password
                               };
    
    // Do your network operation
    [[CLClient getInstance] POST:@"v2/authorize.json" parameters:authDict completion:^(id response, NSError *error) {
        if (!error) {
            CLUser *user = [response result];
            NSLog(@"Username: %@", user);
        } else {
            NSLog(@"Error: %@", [error userInfo]);
        }
    }];
}

@end