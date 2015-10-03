//
//  CLAddEventComment.h
//  Cooleaf
//
//  Created by Haider Khan on 9/20/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLAddEventComment : NSObject

@property (nonatomic, assign) NSInteger eventId;
@property (nonatomic, assign) NSString *content;

- (id)initWithId:(NSInteger)eventId content:(NSString *)content;

@end
