//
//  CLAuthenticationEvent.h
//  Cooleaf
//
//  Created by Haider Khan on 8/27/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLAuthenticationEvent : NSObject

@property (nonatomic) NSString *email;
@property (nonatomic) NSString *password;

- (id)initWithCredentials:(NSString *)email :(NSString *)password;

@end