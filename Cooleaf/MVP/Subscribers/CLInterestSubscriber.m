//
//  CLInterestSuscriber.m
//  Cooleaf
//
//  Created by Haider Khan on 8/26/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "CLInterestSubscriber.h"
#import "CLLoadInterests.h"

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
        NSLog(@"%@", interests);
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}

@end