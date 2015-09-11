//
//  IEventInteractor.h
//  Cooleaf
//
//  Created by Haider Khan on 8/31/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

@protocol IEventInteractor <NSObject>

- (void)initEvents:(NSMutableArray *)events;
- (void)initUserEvents:(NSMutableArray *)userEvents;

@end
