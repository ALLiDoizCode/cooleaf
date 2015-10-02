//
//  IFilePreviewInteractor.h
//  Cooleaf
//
//  Created by Haider Khan on 10/2/15.
//  Copyright © 2015 Nova Project. All rights reserved.
//

#import "CLFilePreview.h"

@protocol IFilePreviewInteractor <NSObject>

- (void)initWithFilePreview:(CLFilePreview *)filePreview;

@end
