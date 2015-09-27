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
    // Create params
    NSDictionary *params = @{
                            @"email": event.email,
                            @"password": event.password
                            };
    // Pass to controller
    [_authenticationController authenticate:params success:^(id response) {
        CLUser *user = [response result];
        NSDictionary *userDict = [user dictionaryValue];
        NSString *organizationHeader = userDict[@"role"][@"organization"][@"subdomain"];
        [CLClient setOrganizationHeader:organizationHeader];
        CLAuthenticationSuccessEvent *authenticationSuccessEvent = [[CLAuthenticationSuccessEvent alloc] initWithUser:user];
        PUBLISH(authenticationSuccessEvent);
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}

SUBSCRIBE(CLDeAuthorizeEvent) {
    
    // Access NSUserDefaults
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *username = [userDefaults objectForKey:@"username"];
    
    // Set username and password to null
    [userDefaults setObject:@"" forKey:username];
    [SSKeychain setPassword:@"" forService:@"cooleaf" account:username];
    
    // Go ahead and deauthorize
    [_authenticationController deauthenticate:nil success:^(id JSON) {
        NSLog(@"deauthentication successfull");
        CLDeAuthorizedEvent *deauthorizedEvent = [[CLDeAuthorizedEvent alloc] init];
        PUBLISH(deauthorizedEvent);
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}

@end