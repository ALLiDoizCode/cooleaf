//
//  CLAuthenticationController.m
//  Cooleaf
//
//  Created by Haider Khan on 8/25/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "CLAuthenticationController.h"

@implementation CLAuthenticationController

# pragma authenticate

- (void)authenticate:(NSString *)email :(NSString *)password {
    
    // Get the client
    CLClient *client = [CLClient getInstance];
    
    NSMutableDictionary *authDict = [NSMutableDictionary dictionary];
    authDict[@"email"] = email;
    authDict[@"password"] = password;
    
    // Do your network operation
    [client POST:@"users/authorize.json" parameters:authDict completion:^(id response, NSError *error) {
        if (!error) {
            CLUser *user = response;
            [[NSNotificationCenter defaultCenter] postNotificationName:@"authenticationEvent" object:user];
        } else {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"errorAuthentication" object:self];
        }
    }];
    
}


# pragma deauthenticate



@end
