//
//  CLLoadedUserEvents.h
//  Cooleaf
//
//  Created by Haider Khan on 9/5/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLLoadedUserEvents : NSObject

@property (nonatomic) NSMutableArray *events;

- (id)initWithUserEvents:(NSMutableArray *)events;

@end
