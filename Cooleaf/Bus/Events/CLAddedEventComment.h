//
//  CLAddedEventComment.h
//  Cooleaf
//
//  Created by Haider Khan on 9/20/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CLComment.h"

@interface CLAddedEventComment : NSObject

@property (nonatomic, assign) CLComment *comment;

- (id)initWithComment:(CLComment *)comment;

@end
