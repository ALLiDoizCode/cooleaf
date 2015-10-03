//
//  CLAuthenticateNewUserEvent.h
//  Cooleaf
//
//  Created by Haider Khan on 9/30/15.
//  Copyright © 2015 Nova Project. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLAuthenticateNewUserEvent : NSObject

@property (nonatomic, assign) NSString *email;
@property (nonatomic, assign) NSString *password;

- (id)initWithEmail:(NSString *)email password:(NSString *)password;

@end
