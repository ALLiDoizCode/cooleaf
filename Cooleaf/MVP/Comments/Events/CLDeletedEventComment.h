//
//  CLDeletedEventComment.h
//  Cooleaf
//
//  Created by Haider Khan on 9/21/15.
//  Copyright © 2015 Nova Project. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CLComment.h"

@interface CLDeletedEventComment : NSObject

@property (nonatomic, assign) CLComment *comment;

- (id)initWithComment:(CLComment *)comment;

@end
