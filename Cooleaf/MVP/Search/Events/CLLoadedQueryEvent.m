//
//  CLLoadedQueryEvent.m
//  Cooleaf
//
//  Created by Haider Khan on 9/14/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "CLLoadedQueryEvent.h"

@implementation CLLoadedQueryEvent

- (id)initWithResults:(NSMutableArray *)results {
    _results = results;
    return self;
}

@end
