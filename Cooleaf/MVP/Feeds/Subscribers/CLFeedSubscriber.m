//
//  CLFeedSubscriber.m
//  Cooleaf
//
//  Created by Haider Khan on 9/18/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "CLFeedSubscriber.h"
#import "CLFeedController.h"
#import "CLLoadInterestFeeds.h"
#import "CLLoadedInterestFeeds.h"

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

# pragma mark - subscription events

SUBSCRIBE(CLLoadInterestFeeds) {
    NSInteger interestId = event.interestId;
    NSDictionary *params = @{
                             @"page": [NSString stringWithFormat:@"%lu", (long) event.page],
                             @"per_page": [NSString stringWithFormat:@"%lu", (long) event.perPage]
                             };
    
    [_feedController getInterestFeeds:interestId params:params success:^(id JSON) {
        NSMutableArray *feeds = [JSON result];
        CLLoadedInterestFeeds *loadedInterestFeeds = [[CLLoadedInterestFeeds alloc] initWithFeeds:feeds];
        PUBLISH(loadedInterestFeeds);
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}

@end
