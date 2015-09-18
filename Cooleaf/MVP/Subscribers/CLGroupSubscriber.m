//
//  CLGroupSubscriber.m
//  Cooleaf
//
//  Created by Haider Khan on 9/18/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "CLGroupSubscriber.h"
#import "CLGroupController.h"

@interface CLGroupSubscriber() {
    @private
    CLGroupController *_groupController;
}

@end

@implementation CLGroupSubscriber

# pragma mark - init

- (id)init {
    _groupController = [[CLGroupController alloc] init];
    return self;
}

# pragma mark - subscription methods



@end
