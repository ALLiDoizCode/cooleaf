//
//  CLFilePreviewPresenter.m
//  Cooleaf
//
//  Created by Haider Khan on 10/2/15.
//  Copyright © 2015 Nova Project. All rights reserved.
//

#import "CLFilePreviewPresenter.h"
#import "CLBus.h"
#import "CLUploadPhotoEvent.h"

@implementation CLFilePreviewPresenter

# pragma mark - Init

- (id)initWithInteractor:(id<IFilePreviewInteractor>)interactor {
    _filePreviewInfo = interactor;
    return self;
}

# pragma mark - Bus Methods

- (void)registerOnBus {
    REGISTER();
}

- (void)unregisterOnBus {
    UNREGISTER();
}

# pragma mark - uploadPhoto

- (void)uploadPhoto:(UIImage *)image {
    NSData *imageData = UIImagePNGRepresentation(image);
    PUBLISH([[CLUploadPhotoEvent alloc] initWithData:imageData]);
}

@end
