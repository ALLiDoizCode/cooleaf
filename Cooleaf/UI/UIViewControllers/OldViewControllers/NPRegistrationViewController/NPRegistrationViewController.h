//
//  NPRegistrationViewController.h
//  Cooleaf
//
//  Created by Curtis Jones on 2015.03.07.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLRegistration.h"
#import "IRegistrationInteractor.h"
#import "IAuthenticationInteractor.h"
#import "IFilePreviewInteractor.h"

@interface NPRegistrationViewController : UIViewController <IRegistrationInteractor, IAuthenticationInteractor, IFilePreviewsInteractor>

@property (nonatomic, strong) CLRegistration *registration;

- (id)initWithUsername:(NSString *)username andPassword:(NSString *)password;

@end
