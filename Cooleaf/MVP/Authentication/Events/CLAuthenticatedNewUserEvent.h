//
//  CLAuthenticatedNewUserEvent.h
//  Cooleaf
//
//  Created by Haider Khan on 9/30/15.
//  Copyright © 2015 Nova Project. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CLUser.h"

@interface CLAuthenticatedNewUserEvent : NSObject

@property (nonatomic, assign) CLUser *user;

- (id)initWithUser:(CLUser *)user;

@end
