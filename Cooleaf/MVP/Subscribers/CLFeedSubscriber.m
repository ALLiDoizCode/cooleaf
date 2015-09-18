//
//  CLFeedSubscriber.m
//  Cooleaf
//
//  Created by Haider Khan on 9/18/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "CLFeedSubscriber.h"
#import "CLFeedController.h"

@interface CLFeedSubscriber() {
    @private
    CLFeedController *_feedController;
}

@end

@implementation CLFeedSubscriber

# pragma mark - init

- (id)init {
    _feedController = [[CLFeedController alloc] init];
    return self;
}

@end
