//
//  CLFilePreviewPresenter.h
//  Cooleaf
//
//  Created by Haider Khan on 10/2/15.
//  Copyright © 2015 Nova Project. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IFilePreviewInteractor.h"

@interface CLFilePreviewPresenter : NSObject

@property (nonatomic, assign) id<IFilePreviewInteractor> filePreviewInfo;

- (id)initWithInteractor:(id<IFilePreviewInteractor>)interactor;
- (void)registerOnBus;
- (void)unregisterOnBus;
- (void)uploadPhoto:(UIImage *)image;

@end
