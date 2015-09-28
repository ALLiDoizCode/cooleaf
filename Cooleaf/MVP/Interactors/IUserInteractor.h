//
//  IUserInteractor.h
//  Cooleaf
//
//  Created by Haider Khan on 9/15/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "CLUser.h"

@protocol IUserInteractor <NSObject>

- (void)initMe:(CLUser *)user;
- (void)initOrganizationUsers:(NSMutableArray *)organizationUsers;

@end