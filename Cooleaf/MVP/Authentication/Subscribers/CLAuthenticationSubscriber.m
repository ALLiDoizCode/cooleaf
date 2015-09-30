//
//  CLAuthenticationSubscriber.m
//  Cooleaf
//
//  Created by Haider Khan on 8/26/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "CLAuthenticationSubscriber.h"
#import "CLDeAuthorizeEvent.h"
#import "SSKeychain.h"
#import "CLDeAuthorizedEvent.h"
#import "CLAuthenticationFailedEvent.h"

static NSString *const kCLOrganizatonHeader = @"X-Organization";

@interface CLAuthenticationSubscriber() {
    @private
    CLAuthenticationController *_authenticationController;
}

@end

@implementation CLAuthenticationSubscriber

# pragma init

- (id)init {
    _authenticationController = [[CLAuthenticationController alloc] init];
    return self;
}

# pragma authenticateEvent

SUBSCRIBE(CLAuthenticationEvent) {
    
    // Create params, initialize email, password from the event, and device id from the client
    NSDictionary *params = @{
                            @"email": event.email,
                            @"password": event.password,
                            @"device_id": [CLClient getInstance].notificationUDID
                            };
    // Pass to controller
    [_authenticationController authenticate:params success:^(id response) {
        
        // Catch cookies
        [[CLClient getInstance] saveCookies];
        
        // Get user
        CLUser *user = [response result];
        NSDictionary *userDict = [user dictionaryValue];
        
        // Save user in NSUserDefaults
        [self saveUser:userDict email:event.email password:event.password];
        
        // Set the organization header
        NSString *organizationHeader = userDict[@"role"][@"organization"][@"subdomain"];
        [CLClient setOrganizationHeader:organizationHeader];
        
        // Send out a successful authentication event
        CLAuthenticationSuccessEvent *authenticationSuccessEvent = [[CLAuthenticationSuccessEvent alloc] initWithUser:user];
        PUBLISH(authenticationSuccessEvent);
    } failure:^(NSError *error) {
        [self clearSensitiveUserDefaults];
        [self showLoginFailedAlertView];
        CLAuthenticationFailedEvent *authFailedEvent = [[CLAuthenticationFailedEvent alloc] init];
        PUBLISH(authFailedEvent);
    }];
}

SUBSCRIBE(CLDeAuthorizeEvent) {
    
    // Access NSUserDefaults
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *username = [userDefaults objectForKey:@"username"];
    
    // Set username to null and delete password
    [userDefaults setObject:@"" forKey:username];
    [SSKeychain deletePasswordForService:@"cooleaf" account:username];
    
    // Go ahead and deauthorize
    [_authenticationController deauthenticate:nil success:^(id JSON) {
        [self clearSensitiveUserDefaults];
        CLDeAuthorizedEvent *deauthorizedEvent = [[CLDeAuthorizedEvent alloc] init];
        PUBLISH(deauthorizedEvent);
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}

# pragma mark - Accessory Methods

- (void)saveUser:(NSDictionary *)userDict email:(NSString *)email password:(NSString *)password {
    
    // Save organization header
    NSString *organizationHeader = userDict[@"role"][@"organization"][@"subdomain"];
    [[NSUserDefaults standardUserDefaults] setObject:organizationHeader forKey:@"X-Organization"];
    
    // Set a logged in flag
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isLoggedIn"];
    
    // Set in email and password as the defaults
    [[NSUserDefaults standardUserDefaults] setObject:email forKey:@"username"];
    [SSKeychain setPassword:password forService:@"cooleaf" account:email];
}

- (void)clearUserDefaults {
    
    // Clear organization header
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"X-Organization"];
    
    // Clear logged in flag
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isLoggedIn"];
    
    // Clear credentials
    NSString *username = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
    [SSKeychain deletePasswordForService:@"cooleaf" account:username];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"username"];
}

- (void)clearSensitiveUserDefaults {
    
    // Clear organization header
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"X-Organization"];
    
    // Clear logged in flag
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"isLoggedIn"];
    
    // Clear credentials
    NSString *username = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
    [SSKeychain deletePasswordForService:@"cooleaf" account:username];
}

- (void)showLoginFailedAlertView {
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Log In Failed", @"Sign in failure alert title")
                                                 message:NSLocalizedString(@"Invalid username/password or account not yet activated. Please ‘Sign Up’ to activate your account or try again with your corporate email.", @"Wrong credentials given. Server responded with error")
                                                delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
    [av show];

}

@end