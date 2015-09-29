//
//  CLLoadUsersEvent.h
//  Cooleaf
//
//  Created by Haider Khan on 9/15/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLLoadUsersEvent : NSObject

@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger perPage;

- (id)initWithPage:(NSInteger)page perPage:(NSInteger)perPage;

@end
