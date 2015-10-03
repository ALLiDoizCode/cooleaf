//
//  CLFilePreviewPresenter.h
//  Cooleaf
//
//  Created by Haider Khan on 10/2/15.
//  Copyright © 2015 Nova Project. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IFilePreviewInteractor.h"

@interface CLFilePreviewsPresenter : NSObject

@property (nonatomic, assign) id<IFilePreviewsInteractor> filePreviewInfo;

- (id)initWithInteractor:(id<IFilePreviewsInteractor>)interactor;
- (void)registerOnBus;
- (void)unregisterOnBus;
- (void)uploadProfilePhoto:(UIImage *)image;

@end
