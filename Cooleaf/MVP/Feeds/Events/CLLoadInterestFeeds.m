//
//  CLLoadInterestFeeds.m
//  Cooleaf
//
//  Created by Haider Khan on 9/18/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "CLLoadInterestFeeds.h"

@implementation CLLoadInterestFeeds

- (id)initWithId:(NSInteger)interestId page:(NSInteger)page perPage:(NSInteger)perPage {
    _interestId = interestId;
    _page = page;
    _perPage = perPage;
    return self;
}

@end
