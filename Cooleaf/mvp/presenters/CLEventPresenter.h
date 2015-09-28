//
//  CLEventPresenter.h
//  Cooleaf
//
//  Created by Haider Khan on 8/25/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IEventInteractor.h"
#import "IEventDetailInteractor.h"

@interface CLEventPresenter : NSObject

@property (nonatomic, assign) id<IEventInteractor> eventInfo;
@property (nonatomic, assign) id<IEventDetailInteractor> eventDetailInfo;

- (id)initWithInteractor:(id<IEventInteractor>)interactor;
- (id)initWithDetailInteractor:(id<IEventDetailInteractor>)interactor;
- (void)registerOnBus;
- (void)unregisterOnBus;
- (void)loadEvents;
- (void)loadUserEvents:(NSString *)scope userIdString:(NSString *)userIdString;

@end
