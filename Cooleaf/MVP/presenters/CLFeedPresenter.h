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

- (id)initWithInteractor:(id<IFeedInteractor>)interactor;
- (void)registerOnBus;
- (void)unregisterOnBus;

@end
