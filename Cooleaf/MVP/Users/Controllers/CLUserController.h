//
//  CLUserController.h
//  Cooleaf
//
//  Created by Haider Khan on 8/25/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLUserController : NSObject

- (void)getMe:(NSDictionary *)params success:(void (^)(id JSON))success
      failure:(void (^)(NSError *error))failure;
- (void)getUsers:(NSDictionary *)params success:(void (^)(id JSON))success
             failure:(void (^)(NSError *error))failure;
- (void)saveUserInterests:(NSDictionary *)params success:(void (^)(id JSON))success
                  failure:(void (^)(NSError *error))failure;

@end
