//
//  CLLoadedMeEvent.h
//  Cooleaf
//
//  Created by Haider Khan on 9/28/15.
//  Copyright © 2015 Nova Project. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CLUser.h"

@interface CLLoadedMeEvent : NSObject

@property (nonatomic, strong) CLUser *user;

- (id)initWithUser:(CLUser *)user;

@end
