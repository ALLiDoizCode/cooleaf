//
//  IUserInteractor.h
//  Cooleaf
//
//  Created by Haider Khan on 9/29/15.
//  Copyright © 2015 Nova Project. All rights reserved.
//

#import "CLUser.h"

@protocol IUserInteractor <NSObject>

- (void)initMe:(CLUser *)user;
- (void)initOrganizationUsers:(NSMutableArray *)organizationUsers;

@end