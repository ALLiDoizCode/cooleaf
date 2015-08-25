//
//  CLAuthenticationController.h
//  Cooleaf
//
//  Created by Haider Khan on 8/25/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CLUser.h"
#import "CLClient.h"

@interface CLAuthenticationController : NSObject

- (CLUser *)authenticate;

@end
