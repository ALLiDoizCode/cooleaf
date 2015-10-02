//
//  CLFilePreviewSubscriber.m
//  Cooleaf
//
//  Created by Haider Khan on 10/2/15.
//  Copyright © 2015 Nova Project. All rights reserved.
//

#import "CLFilePreviewSubscriber.h"
#import "CLFilePreviewsController.h"
#import "CLBus.h"
#import "CLUploadPhotoEvent.h"

@interface CLFilePreviewSubscriber() {
    @private
    CLFilePreviewsController *_filePreviewController;
}

@end

@implementation CLFilePreviewSubscriber

# pragma mark - init

- (id)init {
    _filePreviewController = [[CLFilePreviewsController alloc] init];
    return self;
}

# pragma mark - subscription methods

SUBSCRIBE(CLUploadPhotoEvent) {
    
}

@end
