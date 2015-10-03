//
//  IRegistrationInteractor.h
//  Cooleaf
//
//  Created by Haider Khan on 9/29/15.
//  Copyright © 2015 Nova Project. All rights reserved.
//

#import "CLRegistration.h"
#import "CLUser.h"
@protocol IRegistrationInteractor <NSObject>

@optional
- (void)registrationCheckSuccess:(CLRegistration *)registration;

@optional
- (void)registrationCheckFailed;

@optional
- (void)registeredUser:(CLUser *)user;

@optional
- (void)registerFailed;

@end