//
//  CLRegisterUserEvent.h
//  Cooleaf
//
//  Created by Haider Khan on 9/30/15.
//  Copyright © 2015 Nova Project. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLRegisterUserEvent : NSObject

@property (nonatomic, assign) NSString *token;
@property (nonatomic, assign) NSString *name;
@property (nonatomic, assign) NSString *password;
@property (nonatomic, assign) NSMutableArray *tags;

- (id)initWithToken:(NSString *)token name:(NSString *)name password:(NSString *)password tags:(NSMutableArray *)tags;

@end
