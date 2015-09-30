//
//  IRegistrationInteractor.h
//  Cooleaf
//
//  Created by Haider Khan on 9/29/15.
//  Copyright © 2015 Nova Project. All rights reserved.
//

#import "CLRegistration.h"
@protocol IRegistrationInteractor <NSObject>

- (void)registrationCheckSuccess:(CLRegistration *)registration;
- (void)registrationFailed;

@end