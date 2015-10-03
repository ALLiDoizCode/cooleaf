//
//  CLFilePreviewSubscriber.m
//  Cooleaf
//
//  Created by Haider Khan on 10/2/15.
//  Copyright © 2015 Nova Project. All rights reserved.
//

#import "CLFilePreviewsSubscriber.h"
#import "CLFilePreviewsController.h"
#import "CLBus.h"
#import "CLUploadProfilePhotoEvent.h"
#import "CLFilePreview.h"


@interface CLFilePreviewsSubscriber() {
    @private
    CLFilePreviewsController *_filePreviewController;
}

@end

@implementation CLFilePreviewsSubscriber

# pragma mark - init

- (id)init {
    _filePreviewController = [[CLFilePreviewsController alloc] init];
    return self;
}

# pragma mark - subscription methods

SUBSCRIBE(CLUploadProfilePhotoEvent) {
    // Get the data from the event
    NSData *data = event.data;
    
    [_filePreviewController uploadProfilePhoto:data params:nil success:^(id JSON) {
        CLFilePreview *filePreview = [JSON result];
        NSLog(@"%@", filePreview);
    } failure:^(NSError *error) {
        NSString *errorMessage = [error localizedDescription];
        [self showUploadProfileErrorAlert:errorMessage];
    }];
}

# pragma mark - Accessory Methods

- (void)showUploadProfileErrorAlert:(NSString *)errorMessage {
    [[[UIAlertView alloc] initWithTitle:@"Upload Photo Failed" message:errorMessage delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
}

@end
