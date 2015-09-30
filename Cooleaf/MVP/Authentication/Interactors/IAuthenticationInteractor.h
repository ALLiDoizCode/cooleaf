//
//  IAuthenticationInteractor.h
//  Cooleaf
//
//  Created by Haider Khan on 9/29/15.
//  Copyright © 2015 Nova Project. All rights reserved.
//

#import "CLUser.h"

@protocol IAuthenticationInteractor <NSObject>

@optional
- (void)initUser:(CLUser *)user;
- (void)authenticationFailed;
- (void)deAuthorized;
- (void)newUserAuthenticated:(CLUser *)user;

@end
