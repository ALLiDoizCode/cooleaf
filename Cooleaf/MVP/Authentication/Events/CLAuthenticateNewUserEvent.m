//
//  CLAuthenticateNewUserEvent.m
//  Cooleaf
//
//  Created by Haider Khan on 9/30/15.
//  Copyright © 2015 Nova Project. All rights reserved.
//

#import "CLAuthenticateNewUserEvent.h"

@implementation CLAuthenticateNewUserEvent

- (id)initWithEmail:(NSString *)email password:(NSString *)password {
    _email = email;
    _password = password;
    return self;
}

@end
