//
//  CLAuthenticationPresenter.m
//  Cooleaf
//
//  Created by Haider Khan on 8/25/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "CLAuthenticationPresenter.h"
#import "CLLogin.h"

@implementation CLAuthenticationPresenter {
    
@private
    id <AddUserInfo> _userInfo;
    
}

@synthesize userInfo = _userInfo;


- (CLAuthenticationPresenter *)initWithAddUserInfo:(id <AddUserInfo>)userInfo {
    
    if (self = [super init]) {
        
        _userInfo = userInfo;
    }
    
    return self;
}

#pragma authenticate

- (void)authenticate:(NSString *)email :(NSString *)password {
    
    NSArray *userInfo = [NSArray arrayWithObjects: email,password,nil];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"login" object:userInfo];
}

///Protocols 
#pragma errorMessage

- (void)errorMessage:(NSString *)message {
    
}

@end
