//
//  CLRegistrationSubscriber.m
//  Cooleaf
//
//  Created by Haider Khan on 9/29/15.
//  Copyright © 2015 Nova Project. All rights reserved.
//

#import "CLRegistrationSubscriber.h"
#import "CLRegistrationController.h"
#import "CLCheckRegistrationEvent.h"
#import "CLCheckedRegistrationEvent.h"
#import "CLRegistration.h"
#import "CLFailedRegistrationEvent.h"
#import "CLRegisterUserEvent.h"
#import "CLUser.h"
#import "CLRegisteredUserEvent.h"

@interface CLRegistrationSubscriber() {
    @private
    CLRegistrationController *_registrationController;
}

@end

@implementation CLRegistrationSubscriber

# pragma mark - init

- (id)init {
    _registrationController = [[CLRegistrationController alloc] init];
    return self;
}

# pragma mark - subscription events

SUBSCRIBE(CLCheckRegistrationEvent) {
    // Get email
    NSString *email = event.email;
    
    // Set params
    NSDictionary *params = @{
                             @"email": email
                             };
    
    [_registrationController checkRegistrationWithParams:params success:^(id JSON) {
        CLRegistration *registration = [JSON result];
        CLCheckedRegistrationEvent *checkedRegistrationEvent = [[CLCheckedRegistrationEvent alloc] initWithRegistration:registration];
        PUBLISH(checkedRegistrationEvent);
    } failure:^(NSError *error) {
        [[[UIAlertView alloc] initWithTitle:@"Registration Failed" message:@"Please make sure to use your corporate email or try to ‘Log In’ as you may have already activated your account." delegate:nil cancelButtonTitle:@"Try Again" otherButtonTitles:nil] show];
        CLFailedRegistrationEvent *failedRegistrationEvent = [[CLFailedRegistrationEvent alloc] init];
        PUBLISH(failedRegistrationEvent);
    }];
}

SUBSCRIBE(CLRegisterUserEvent) {
    // Get values
    NSString *token = event.token;
    NSString *username = event.name;
    NSString *password = event.password;
    NSMutableArray *tags = event.tags;
    
    // Set params
    NSDictionary *params = @{
                                 @"token": token,
                                 @"name": username,
                                 @"password": password,
                                 @"tag_ids": tags
                                 };
    
    // Go ahead and hit the api to register
    [_registrationController registerUserWithParams:params success:^(id JSON) {
        CLUser *user = [JSON result];
        NSLog(@"%@", user);
        CLRegisteredUserEvent *registeredUserEvent = [[CLRegisteredUserEvent alloc] initWithUser:user];
        PUBLISH(registeredUserEvent);
    } failure:^(NSError *error) {
        [[[UIAlertView alloc] initWithTitle:@"Registration Failed" message:@"Please make sure to use your corporate email or try to ‘Log In’ as you may have already activated your account." delegate:nil cancelButtonTitle:@"Try Again" otherButtonTitles:nil] show];
        NSLog(@"%@", error);
    }];
}

@end
