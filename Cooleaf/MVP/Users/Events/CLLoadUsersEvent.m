//
//  CLLoadUsersEvent.m
//  Cooleaf
//
//  Created by Haider Khan on 9/15/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "CLLoadUsersEvent.h"

@implementation CLLoadUsersEvent

- (id)initWithPage:(NSInteger)page perPage:(NSInteger)perPage {
    _page = page;
    _perPage = perPage;
    return self;
}

@end
