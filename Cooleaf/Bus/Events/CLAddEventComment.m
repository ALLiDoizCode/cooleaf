//
//  CLAddEventComment.m
//  Cooleaf
//
//  Created by Haider Khan on 9/20/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "CLAddEventComment.h"

@implementation CLAddEventComment

- (id)initWithId:(NSInteger)eventId content:(NSString *)content {
    _eventId = eventId;
    _content = content;
    return self;
}

@end
