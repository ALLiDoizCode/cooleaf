//
//  CLGroupPresenter.h
//  Cooleaf
//
//  Created by Haider Khan on 9/18/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IGroupInteractor.h"
#import "IGroupDetailInteractor.h"

@interface CLGroupPresenter : NSObject

@property (nonatomic, assign) id<IGroupInteractor> groupInfo;
@property (nonatomic, assign) id<IGroupDetailInteractor> groupDetailInfo;

- (id)initWithInteractor:(id<IGroupInteractor>)interactor;
- (id)initWithDetailInteractor:(id<IGroupDetailInteractor>)interactor;
- (void)registerOnBus;
- (void)unregisterOnBus;

@end
