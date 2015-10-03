//
//  CLAuthenticationSuccessEvent.m
//  Cooleaf
//
//  Created by Haider Khan on 8/27/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "CLAuthenticationSuccessEvent.h"

@implementation CLAuthenticationSuccessEvent

- (id)initWithUser:(CLUser *)user {
    _user = user;
    return self;
}

@end
