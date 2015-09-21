//
//  CLDeleteEventComment.h
//  Cooleaf
//
//  Created by Haider Khan on 9/21/15.
//  Copyright © 2015 Nova Project. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLDeleteEventComment : NSObject

@property (nonatomic, assign) NSInteger eventId;
@property (nonatomic, assign) NSInteger commentId;

- (id)initWithEventId:(NSInteger)eventId commentId:(NSInteger)commentId;

@end
