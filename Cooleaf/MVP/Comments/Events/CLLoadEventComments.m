//
//  CLLoadEventComments.m
//  Cooleaf
//
//  Created by Haider Khan on 9/20/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "CLLoadEventComments.h"

@implementation CLLoadEventComments

- (id)initWithId:(NSInteger)eventId page:(NSInteger)page perPage:(NSInteger)perPage {
    _eventId = eventId;
    _page = page;
    _perPage = perPage;
    return self;
}

@end
