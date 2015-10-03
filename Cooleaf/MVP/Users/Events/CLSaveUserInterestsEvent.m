//
//  CLSaveUserInterestsEvent.m
//  Cooleaf
//
//  Created by Haider Khan on 10/2/15.
//  Copyright © 2015 Nova Project. All rights reserved.
//

#import "CLSaveUserInterestsEvent.h"

@implementation CLSaveUserInterestsEvent

- (id)initWithUser:(CLUser *)user activeInterests:(NSMutableArray *)activeInterests fileCache:(NSString *)fileCache {
    _user = user;
    _activeInterests = activeInterests;
    _fileCache = fileCache;
    return self;
}

@end
