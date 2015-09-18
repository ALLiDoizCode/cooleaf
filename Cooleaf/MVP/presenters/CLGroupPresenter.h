//
//  CLGroupPresenter.h
//  Cooleaf
//
//  Created by Haider Khan on 9/18/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IGroupInteractor.h"

@interface CLGroupPresenter : NSObject

@property (nonatomic, assign) id<IGroupInteractor> groupInfo;

- (id)initWithInteractor:(id<IGroupInteractor>)interactor;
- (void)registerOnBus;
- (void)unregisterOnBus;

@end
