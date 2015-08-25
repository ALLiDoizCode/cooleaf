//
//  CLAuthenticationController.m
//  Cooleaf
//
//  Created by Haider Khan on 8/25/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "CLAuthenticationController.h"

@implementation CLAuthenticationController

# pragma authenticate the user

- (CLUser *)authenticate {
    
    // Get the client
    CLClient *client = [CLClient getInstance];
    
    // Do your network operation
    // ....
    
    CLUser *user = [[CLUser alloc] init];
    return user;
}

@end
