//
//  CLRegisteredUserEvent.m
//  Cooleaf
//
//  Created by Haider Khan on 9/30/15.
//  Copyright © 2015 Nova Project. All rights reserved.
//

#import "CLRegisteredUserEvent.h"

@implementation CLRegisteredUserEvent

- (id)initWithUser:(CLUser *)user {
    _user = user;
    return self;
}

@end
