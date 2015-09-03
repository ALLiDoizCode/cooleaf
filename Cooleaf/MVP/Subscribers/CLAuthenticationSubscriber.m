//
//  CLAuthenticationSubscriber.m
//  Cooleaf
//
//  Created by Haider Khan on 8/26/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "CLAuthenticationSubscriber.h"

static NSString *const kCLOrganizatonHeader = @"X-Organization";

@interface CLAuthenticationSubscriber() {
    @private
    CLAuthenticationController *authenticationController;
}

@end

@implementation CLAuthenticationSubscriber

# pragma init

- (id)init {
    authenticationController = [[CLAuthenticationController alloc] init];
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
    [authenticationController authenticate:params success:^(id response) {
        CLUser *user = [MTLJSONAdapter modelOfClass:[CLUser class] fromJSONDictionary:[response result] error:nil];
        NSString *organizationHeader = [response result][@"role"][@"organization"][@"subdomain"];
        [CLClient setOrganizationHeader:organizationHeader];
        CLAuthenticationSuccessEvent *authenticationSuccessEvent = [[CLAuthenticationSuccessEvent alloc] initWithUser:user];
        PUBLISH(authenticationSuccessEvent);
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}

@end