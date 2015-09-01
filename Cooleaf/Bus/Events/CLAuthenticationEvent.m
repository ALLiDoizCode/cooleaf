//
//  CLAuthenticationEvent.m
//  Cooleaf
//
//  Created by Haider Khan on 8/27/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "CLAuthenticationEvent.h"

@implementation CLAuthenticationEvent

- (id)initWithCredentials:(NSString *)email :(NSString *)password {
    _email = email;
    _password = password;
    return self;
}

@end