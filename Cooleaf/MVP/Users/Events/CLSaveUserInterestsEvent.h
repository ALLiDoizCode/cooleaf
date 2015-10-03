//
//  CLSaveUserInterestsEvent.h
//  Cooleaf
//
//  Created by Haider Khan on 10/2/15.
//  Copyright © 2015 Nova Project. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CLUser.h"

@interface CLSaveUserInterestsEvent : NSObject

@property (nonatomic, assign) CLUser *user;
@property (nonatomic, assign) NSMutableArray *activeInterests;
@property (nonatomic, assign) NSString *fileCache;

- (id)initWithUser:(CLUser *)user activeInterests:(NSMutableArray *)activeInterests fileCache:(NSString *)fileCache;

@end
