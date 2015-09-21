//
//  CLDeleteEventComment.m
//  Cooleaf
//
//  Created by Haider Khan on 9/21/15.
//  Copyright © 2015 Nova Project. All rights reserved.
//

#import "CLDeleteEventComment.h"

@implementation CLDeleteEventComment

- (id)initWithEventId:(NSInteger)eventId commentId:(NSInteger)commentId {
    _eventId = eventId;
    _commentId = commentId;
    return self;
}

@end
