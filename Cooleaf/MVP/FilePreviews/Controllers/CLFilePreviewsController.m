//
//  CLFilePreviewsController.m
//  Cooleaf
//
//  Created by Haider Khan on 10/2/15.
//  Copyright © 2015 Nova Project. All rights reserved.
//

#import "CLFilePreviewsController.h"
#import "CLClient.h"

static NSString *const kFilePreviewsPath = @"v2/file_previews.json";
static NSString *const kImageMimeType = @"image/jpeg";

@implementation CLFilePreviewsController

- (void)uploadProfilePhoto:(NSData *)data params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    
    // Create filename - api needs different filenames
    int file = arc4random_uniform(742904857);
    NSString *fileNameString = [NSString stringWithFormat:@"%d.jpg", file];
    
    // Append NSData and uploader path with file name
    [[CLClient getInstance] POST:kFilePreviewsPath
                      parameters:params
       constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
           [formData appendPartWithFormData:[NSData dataWithBytes:@"profile_picture" length:15] name:@"uploader"];
           [formData appendPartWithFileData:data name:@"file" fileName:fileNameString mimeType:kImageMimeType];
       } completion:^(id response, NSError *error) {
           if (!error)
               success(response);
           else
               failure(error);
    }];
}

@end
