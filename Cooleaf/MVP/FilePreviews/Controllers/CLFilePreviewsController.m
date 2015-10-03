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
    
    [[CLClient getInstance] POST:kFilePreviewsPath parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        // Set the uploader form data
        NSString *uploader = @"profile_picture";
        [formData appendPartWithFormData:[uploader dataUsingEncoding:NSUTF8StringEncoding] name:@"uploader"];
        
        // Set the file in the formdata
        [formData appendPartWithFileData:data name:@"file" fileName:fileNameString mimeType:kImageMimeType];
    } success:^(AFHTTPRequestOperation *operation, id response) {
        success(response);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];
}

@end
