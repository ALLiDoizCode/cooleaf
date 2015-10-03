//
//  CLAuthenticationSuccessEvent.h
//  Cooleaf
//
//  Created by Haider Khan on 8/27/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CLUser.h"

@interface CLAuthenticationSuccessEvent : NSObject

@property (nonatomic) CLUser *user;

- (id)initWithUser:(CLUser *)user;

@end
