//
//  CLSavedUserInterestsEvent.h
//  Cooleaf
//
//  Created by Haider Khan on 10/3/15.
//  Copyright © 2015 Nova Project. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CLUser.h"

@interface CLSavedUserInterestsEvent : NSObject

@property (nonatomic, assign) CLUser *user;

- (id)initWithUser:(CLUser *)user;

@end
