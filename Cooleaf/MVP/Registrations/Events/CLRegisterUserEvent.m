//
//  CLRegisterUserEvent.m
//  Cooleaf
//
//  Created by Haider Khan on 9/30/15.
//  Copyright © 2015 Nova Project. All rights reserved.
//

#import "CLRegisterUserEvent.h"

@implementation CLRegisterUserEvent

- (id)initWithToken:(NSString *)token name:(NSString *)name password:(NSString *)password tags:(NSMutableArray *)tags {
    _token = token;
    _name = name;
    _password = password;
    _tags = tags;
    return self;
}

@end
