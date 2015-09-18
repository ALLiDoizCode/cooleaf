//
//  CLInterestSuscriber.m
//  Cooleaf
//
//  Created by Haider Khan on 8/26/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "CLInterestSubscriber.h"
#import "CLLoadInterests.h"
#import "CLLoadedInterests.h"
#import "CLLoadInterestMembers.h"
#import "CLLoadedInterestMembers.h"
#import "CLLoadJoinInterest.h"
#import "CLLoadLeaveInterest.h"

@interface CLInterestSubscriber() {
    @private
    CLInterestController *_interestController;
}

@end

@implementation CLInterestSubscriber

# pragma init

- (id)init {
    _interestController = [[CLInterestController alloc] init];
    return self;
}

# pragma subscription events

SUBSCRIBE(CLLoadInterests) {
    [_interestController getInterests:nil success:^(id JSON) {
        NSMutableArray *interests = [JSON result];
        CLLoadedInterests *loadedInterests = [[CLLoadedInterests alloc] initWithInterests:interests];
        PUBLISH(loadedInterests);
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}

SUBSCRIBE(CLLoadInterestMembers) {
    
    NSInteger interestId = event.interestId;
    NSDictionary *params = @{
                             @"page": [NSString stringWithFormat:@"%lu", (long) event.page],
                             @"per_page": [NSString stringWithFormat:@"%lu", (long) event.perPage]
                             };
    
    [_interestController getInterestMembers:interestId params:params success:^(id JSON) {
        NSMutableArray *members = [JSON result];
        CLLoadedInterestMembers *interestMembers = [[CLLoadedInterestMembers alloc] initWithMembers:members];
        PUBLISH(interestMembers);
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}

SUBSCRIBE(CLLoadJoinInterest) {
    
    NSInteger interestId = event.interestId;
    [_interestController joinInterest:interestId params:nil success:^(id JSON) {
        NSLog(@"Success!!");
        NSLog(@"%@", JSON);
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}

SUBSCRIBE(CLLoadLeaveInterest) {
    
    NSInteger interestId = event.interestId;
    [_interestController leaveInterest:interestId params:nil success:^(id JSON) {
        NSLog(@"Success!!");
        NSLog(@"%@", JSON);
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}

@end