//
//  CLSearchController.h
//  Cooleaf
//
//  Created by Haider Khan on 9/14/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLSearchController : NSObject

- (void)executeQuery:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure;

@end
