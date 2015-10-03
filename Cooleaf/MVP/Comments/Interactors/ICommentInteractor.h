//
//  ICommentInteractor.h
//  Cooleaf
//
//  Created by Haider Khan on 9/29/15.
//  Copyright © 2015 Nova Project. All rights reserved.
//

#import "CLComment.h"

@protocol ICommentInteractor <NSObject>

- (void)initEventComments:(NSMutableArray *)comments;
- (void)addEventComment:(CLComment *)comment;
- (void)deleteEventComment:(CLComment *)comment;

@end