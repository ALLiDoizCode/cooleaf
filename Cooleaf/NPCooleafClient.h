//
//  NPCooleafClient.h
//  Cooleaf
//
//  Created by Bazyli Zygan on 14.12.2013.
//  Copyright (c) 2013 Nova Project. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"

@interface NPCooleafClient : AFHTTPRequestOperationManager

@property (nonatomic, readonly) NSDictionary *userData;

+ (NPCooleafClient *)sharedClient;

- (AFHTTPRequestOperation *)loginWithUsername:(NSString *)username password:(NSString *)password  completion:(void(^)(NSError *error))completion;

- (void)fetchEventList:(void(^)(NSArray *events))completion;

- (void)fetchImage:(NSString *)imagePath completion:(void(^)(NSString *imagePath, UIImage *image))completion;
@end
