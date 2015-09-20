//
//  CLCommentPresenter.m
//  Cooleaf
//
//  Created by Haider Khan on 9/20/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "CLCommentPresenter.h"
#import "CLBus.h"
#import "CLLoadEventComments.h"
#import "CLLoadedEventComments.h"
#import "CLAddEventComment.h"
#import "CLAddedEventComment.h"

static NSInteger const PAGE = 1;
static NSInteger const PER_PAGE = 25;

@implementation CLCommentPresenter

# pragma mark - Init

- (id)initWithInteractor:(id<ICommentInteractor>)interactor {
    _commentInfo = interactor;
    return self;
}

# pragma mark - Bus Methods

- (void)registerOnBus {
    REGISTER();
}

- (void)unregisterOnBus {
    UNREGISTER();
}

# pragma mark - loadEventComments

- (void)loadEventComments:(NSInteger)eventId {
    PUBLISH([[CLLoadEventComments alloc] initWithId:eventId page:PAGE perPage:PER_PAGE]);
}

# pragma mark - addComment

- (void)addEventComment:(NSInteger)eventId content:(NSString *)content {
    PUBLISH([[CLAddEventComment alloc] initWithId:eventId content:content]);
}

# pragma mark - Subscription Methods

SUBSCRIBE(CLLoadedEventComments) {
    [_commentInfo initEventComments:event.comments];
}

SUBSCRIBE(CLAddedEventComment) {
    [_commentInfo addEventComment:event.comment];
}

@end
