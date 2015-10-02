//
//  CLUploadedPhotoEvent.m
//  Cooleaf
//
//  Created by Haider Khan on 10/2/15.
//  Copyright © 2015 Nova Project. All rights reserved.
//

#import "CLUploadedPhotoEvent.h"

@implementation CLUploadedPhotoEvent

- (id)initWithFilePreview:(CLFilePreview *)filePreview {
    _filePreview = filePreview;
    return self;
}

@end
