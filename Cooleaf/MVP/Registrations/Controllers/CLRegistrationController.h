//
//  CLRegistrationController.h
//  Cooleaf
//
//  Created by Haider Khan on 9/29/15.
//  Copyright © 2015 Nova Project. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLRegistrationController : NSObject

- (void)checkRegistrationWithParams:(NSDictionary *)params success:(void (^)(id JSON))success
failure:(void (^)(NSError *error))failure;

@end
