//
//  CLSearchPresenter.h
//  Cooleaf
//
//  Created by Haider Khan on 9/14/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ISearchInteractor.h"

@interface CLSearchPresenter : NSObject

@property (nonatomic, assign) id<ISearchInteractor> searchInfo;

- (id)initWithInteractor:(id<ISearchInteractor>)interactor;
- (void)registerOnBus;
- (void)unregisterOnBus;
- (void)loadQuery:(NSString *)query scope:(NSString *)scope;

@end
