//
//  CLLoadLeaveEvent.h
//  Cooleaf
//
//  Created by Haider Khan on 9/28/15.
//  Copyright © 2015 Nova Project. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLLoadLeaveEvent : NSObject

@property (nonatomic, assign) NSInteger eventId;

- (id)initWithEventId:(NSInteger)eventId;

@end
