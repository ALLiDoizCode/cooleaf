//
//  ICommentInteractor.h
//  Cooleaf
//
//  Created by Haider Khan on 9/20/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "CLComment.h"
@protocol ICommentInteractor <NSObject>

- (void)initEventComments:(NSMutableArray *)comments;
- (void)addEventComment:(CLComment *)comment;

@end