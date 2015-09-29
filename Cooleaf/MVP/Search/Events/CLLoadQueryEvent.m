//
//  CLLoadQueryEvent.m
//  Cooleaf
//
//  Created by Haider Khan on 9/14/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "CLLoadQueryEvent.h"

@implementation CLLoadQueryEvent

- (id)initWithQuery:(NSString *)query scope:(NSString *)scope page:(NSInteger)page perPage:(NSInteger)perPage {
    _query = query;
    _scope = scope;
    _page = page;
    _perPage = perPage;
    return self;
}

@end
