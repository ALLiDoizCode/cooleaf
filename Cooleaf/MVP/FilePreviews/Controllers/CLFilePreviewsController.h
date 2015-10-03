//
//  CLFilePreviewsController.h
//  Cooleaf
//
//  Created by Haider Khan on 10/2/15.
//  Copyright © 2015 Nova Project. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLFilePreviewsController : NSObject

- (void)uploadProfilePhoto:(NSData *)data params:(NSDictionary *)params success:(void (^)(id JSON))success
           failure:(void (^)(NSError *error))failure;

@end
