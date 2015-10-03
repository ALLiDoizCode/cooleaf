
//
//  CLCommentSubscriber.m
//  Cooleaf
//
//  Created by Haider Khan on 9/20/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "CLCommentSubscriber.h"
#import "CLCommentViewController.h"
#import "CLLoadEventComments.h"
#import "CLCommentController.h"
#import "CLLoadedEventComments.h"
#import "CLAddEventComment.h"
#import "CLAddedEventComment.h"
#import "CLDeleteEventComment.h"
#import "CLDeletedEventComment.h"

@interface CLCommentSubscriber() {
    @private
    CLCommentController *_commentController;
}

@end

@implementation CLCommentSubscriber

# pragma mark - init

- (id)init {
    _commentController = [[CLCommentController alloc] init];
    return self;
}

# pragma mark - subscription events

SUBSCRIBE(CLLoadEventComments) {
    // Initialize parameters
    NSInteger eventId = event.eventId;
    NSDictionary *params = @{
                             @"page": [NSString stringWithFormat:@"%lu", (long) event.page],
                             @"per_page": [NSString stringWithFormat:@"%lu", (long) event.perPage]
                             };
    
    [_commentController getEventComments:eventId params:params success:^(id JSON) {
        NSMutableArray *comments = [JSON result];
        CLLoadedEventComments *loadedEventComments = [[CLLoadedEventComments alloc] initWithComments:comments];
        PUBLISH(loadedEventComments);
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}

SUBSCRIBE(CLAddEventComment) {
    // Initialize parameters
    NSInteger eventId = event.eventId;
    NSString *content = event.content;
    NSDictionary *params = @{
                             @"content": content
                             };
    
    [_commentController addEventComment:eventId params:params success:^(id JSON) {
        CLComment *comment = [JSON result];
        CLAddedEventComment *addedEventComment = [[CLAddedEventComment alloc] initWithComment:comment];
        PUBLISH(addedEventComment);
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}

SUBSCRIBE(CLDeleteEventComment) {
    // Initialize parameters
    NSInteger eventId = event.eventId;
    NSInteger commentid = event.commentId;
    
    [_commentController deleteEventComment:eventId comment:commentid params:nil success:^(id JSON) {
        CLComment *comment = [JSON result];
        CLDeletedEventComment *deletedEventComment = [[CLDeletedEventComment alloc] initWithComment:comment];
        PUBLISH(deletedEventComment);
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}

@end
