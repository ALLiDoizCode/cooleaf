//
//  CLInterestPresenter.h
//  Cooleaf
//
//  Created by Jonathan Green on 8/26/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IInterestInteractor.h"
#import "IInterestDetailInteractor.h"

@interface CLInterestPresenter : NSObject

@property (nonatomic, assign) id<IInterestInteractor> interestInfo;
@property (nonatomic, assign) id<IInterestDetailInteractor> interestDetailInfo;

- (id)initWithInteractor:(id<IInterestInteractor>)interactor;
- (id)initWithDetailInteractor:(id<IInterestDetailInteractor>)interactor;
- (void)registerOnBus;
- (void)unregisterOnBus;
- (void)loadInterests;
- (void)loadInterestMembers:(NSInteger)interestId;

@end
