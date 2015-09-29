//
//  CLLoadedUsersEvent.m
//  Cooleaf
//
//  Created by Haider Khan on 9/15/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "CLLoadedUsersEvent.h"

@implementation CLLoadedUsersEvent

- (id)initWithUsers:(NSMutableArray *)users {
    _users = users;
    return self;
}

@end
