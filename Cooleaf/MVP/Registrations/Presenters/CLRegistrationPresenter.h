//
//  CLRegistrationPresenter.h
//  Cooleaf
//
//  Created by Haider Khan on 9/29/15.
//  Copyright © 2015 Nova Project. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRegistrationInteractor.h"

@interface CLRegistrationPresenter : NSObject

@property (nonatomic, assign) id<IRegistrationInteractor> registrationInfo;

- (id)initWithInteractor:(id<IRegistrationInteractor>)interactor;
- (void)registerOnBus;
- (void)unregisterOnBus;
- (void)checkRegistrationWithEmail:(NSString *)email;
- (void)registerUserWithToken:(NSString *)token name:(NSString *)name password:(NSString *)password tags:(NSMutableArray *)tags;

@end
