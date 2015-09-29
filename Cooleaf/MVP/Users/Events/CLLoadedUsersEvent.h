//
//  CLLoadedUsersEvent.h
//  Cooleaf
//
//  Created by Haider Khan on 9/15/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLLoadedUsersEvent : NSObject

@property (nonatomic, assign) NSMutableArray *users;

- (id)initWithUsers:(NSMutableArray *)users;

@end
