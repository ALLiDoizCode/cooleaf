//
//  CLEventPresenter.h
//  Cooleaf
//
//  Created by Haider Khan on 8/25/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IEventInteractor.h"
#import "CLBus.h"
#import "CLLoadEvents.h"
#import "CLLoadedEvents.h"
#import "CLClient.h"

@interface CLEventPresenter : NSObject

- (id)initWithInteractor:(id<IEventInteractor>)interactor;
- (void)loadEvents;

@end
