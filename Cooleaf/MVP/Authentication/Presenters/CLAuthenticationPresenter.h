//
//  CLAuthenticationPresenter.h
//  Cooleaf
//
//  Created by Haider Khan on 8/25/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CLBus.h"
#import "CLAuthenticationEvent.h"
#import "CLAuthenticationSuccessEvent.h"
#import "CLUser.h"
#import "IAuthenticationInteractor.h"

@interface CLAuthenticationPresenter : NSObject

- (id)initWithInteractor:(id<IAuthenticationInteractor>)interactor;
- (void)registerOnBus;
- (void)unregisterOnBus;
- (void)authenticate:(NSString *)email :(NSString *)password;
- (void)deauthenticate;

@end
