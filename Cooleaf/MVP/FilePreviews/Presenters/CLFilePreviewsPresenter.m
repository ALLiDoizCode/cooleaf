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
#import "CLUploadedProfilePhotoEvent.h"

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
    NSLog(@"uploadProfilePhoto");
    NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
    PUBLISH([[CLUploadProfilePhotoEvent alloc] initWithData:imageData]);
}

# pragma mark - Subscription Methods

SUBSCRIBE(CLUploadedProfilePhotoEvent) {
    if ([_filePreviewInfo respondsToSelector:@selector(initWithFilePreview:)])
        [_filePreviewInfo initWithFilePreview:event.filePreview];
}

@end
