//
//  CLCommentController.h
//  Cooleaf
//
//  Created by Haider Khan on 9/20/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLCommentController : NSObject

- (void)getEventComments:(NSInteger)eventId params:(NSDictionary *)params success:(void (^)(id JSON))success
                 failure:(void (^)(NSError *error))failure;

@end
