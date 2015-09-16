//
//  CLUserSubscriber.m
//  Cooleaf
//
//  Created by Haider Khan on 8/26/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "CLUserSubscriber.h"
#import "CLLoadUsersEvent.h"
#import "CLLoadedUsersEvent.h"

@interface CLUserSubscriber() {
    @private
    CLUserController *_userController;
}

@end

@implementation CLUserSubscriber

# pragma mark - init

- (id)init {
    _userController = [[CLUserController alloc] init];
    return self;
}

# pragma mark - subscription events

SUBSCRIBE(CLLoadUsersEvent) {
    // Load params
    NSDictionary *params = @{
                             @"page": [NSString stringWithFormat:@"%lu", (long) event.page],
                             @"per_page": [NSString stringWithFormat:@"%lu", (long) event.perPage]
                             };
    
    [_userController getUsers:params success:^(id JSON) {
        NSMutableArray *users = [JSON result];
        CLLoadedUsersEvent *loadedUsersEvent = [[CLLoadedUsersEvent alloc] initWithUsers:users];
        PUBLISH(loadedUsersEvent);
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}

@end