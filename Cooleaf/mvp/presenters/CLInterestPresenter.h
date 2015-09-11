//
//  CLInterestPresenter.h
//  Cooleaf
//
//  Created by Jonathan Green on 8/26/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IInterestInteractor.h"

@interface CLInterestPresenter : NSObject

@property (nonatomic, assign) id<IInterestInteractor> interestInfo;

- (id)initWithInteractor:(id<IInterestInteractor>)interactor;
- (void)registerOnBus;
- (void)unregisterOnBus;
- (void)loadInterests;

@end
