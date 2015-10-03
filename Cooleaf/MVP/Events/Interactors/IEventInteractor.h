//
//  IEventInteractor.h
//  Cooleaf
//
//  Created by Haider Khan on 9/29/15.
//  Copyright © 2015 Nova Project. All rights reserved.
//

@protocol IEventInteractor <NSObject>

- (void)joinedEvent;
- (void)leftEvent;
- (void)initEvents:(NSMutableArray *)events;
- (void)initUserEvents:(NSMutableArray *)userEvents;

@end
