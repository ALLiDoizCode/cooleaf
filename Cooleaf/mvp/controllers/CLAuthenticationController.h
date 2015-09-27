//
//  CLAuthenticationController.h
//  Cooleaf
//
//  Created by Haider Khan on 8/25/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OVCResponse.h>
#import "CLUser.h"
#import "CLClient.h"

@interface CLAuthenticationController : NSObject

- (void)authenticate:(NSDictionary *)params success:(void (^)(id JSON))success
          failure:(void (^)(NSError *error))failure;
- (void)deauthenticate:(NSDictionary *)params success:(void (^)(id JSON))success
             failure:(void (^)(NSError *error))failure;

@end
