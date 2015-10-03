//
//  CLUploadedPhotoEvent.h
//  Cooleaf
//
//  Created by Haider Khan on 10/2/15.
//  Copyright © 2015 Nova Project. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CLFilePreview.h"

@interface CLUploadedProfilePhotoEvent : NSObject

@property (nonatomic, strong) CLFilePreview *filePreview;

- (id)initWithFilePreview:(CLFilePreview *)filePreview;

@end
