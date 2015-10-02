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

@implementation CLFilePreviewsController

- (void)uploadPhoto:(NSData *)data params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    [[CLClient getInstance] POST:kFilePreviewsPath
                      parameters:params
       constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
           
       } completion:^(id response, NSError *error) {
        
    }];
}

@end
