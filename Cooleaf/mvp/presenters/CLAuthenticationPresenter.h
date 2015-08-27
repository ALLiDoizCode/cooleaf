//
//  CLAuthenticationPresenter.h
//  Cooleaf
//
//  Created by Haider Khan on 8/25/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AddUserInfo;

@interface CLAuthenticationPresenter : NSObject
@property(nonatomic, strong) id<AddUserInfo> userInfo;

- (void)authenticate:(NSString *)email :(NSString *)password;

- (CLAuthenticationPresenter *)initWithAddUserInfo:(id <AddUserInfo>)userInfo;

- (void)errorMessage:(NSString *)message;

@end
