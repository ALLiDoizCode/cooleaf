//
//  CLFeedPresenter.h
//  Cooleaf
//
//  Created by Haider Khan on 9/18/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IFeedInteractor.h"

@interface CLFeedPresenter : NSObject

@property (nonatomic, assign) id<IFeedInteractor> feedInfo;

- (id)initWithInteractor:(id<IFeedInteractor>)interactor;
- (void)registerOnBus;
- (void)unregisterOnBus;
- (void)loadInterestFeeds:(NSInteger)interestId;

@end
