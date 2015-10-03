//
//  CLFilePreviewPresenter.m
//  Cooleaf
//
//  Created by Haider Khan on 10/2/15.
//  Copyright © 2015 Nova Project. All rights reserved.
//

#import "CLFilePreviewsPresenter.h"
#import "CLBus.h"
#import "CLUploadProfilePhotoEvent.h"

@implementation CLFilePreviewsPresenter

# pragma mark - Init

- (id)initWithInteractor:(id<IFilePreviewsInteractor>)interactor {
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

- (void)uploadProfilePhoto:(UIImage *)image {
    NSData *imageData = UIImagePNGRepresentation(image);
    PUBLISH([[CLUploadProfilePhotoEvent alloc] initWithData:imageData]);
}

@end
