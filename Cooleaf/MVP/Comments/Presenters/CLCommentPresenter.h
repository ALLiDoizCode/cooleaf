//
//  CLCommentPresenter.h
//  Cooleaf
//
//  Created by Haider Khan on 9/20/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ICommentInteractor.h"

@interface CLCommentPresenter : NSObject

@property (nonatomic, assign) id<ICommentInteractor> commentInfo;

- (id)initWithInteractor:(id<ICommentInteractor>)interactor;
- (void)registerOnBus;
- (void)unregisterOnBus;
- (void)loadEventComments:(NSInteger)eventId;
- (void)addEventComment:(NSInteger)eventId content:(NSString *)content;
- (void)deleteEventComment:(NSInteger)eventId commentId:(NSInteger)commentId;

@end
