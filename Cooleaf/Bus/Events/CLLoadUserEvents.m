//
//  CLLoadEventsScope.m
//  Cooleaf
//
//  Created by Haider Khan on 9/5/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "CLLoadUserEvents.h"

@implementation CLLoadUserEvents

- (id)initWithUserId:(NSString *)userIdString page:(NSInteger)page perPage:(NSInteger)perPage scope:(NSString *)scope {
    _userIdString = userIdString;
    _page = page;
    _perPage = perPage;
    _scope = scope;
    return self;
}

@end
