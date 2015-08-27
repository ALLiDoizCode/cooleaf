//
//  CLAuthenticationSubscriber.h
//  Cooleaf
//
//  Created by Haider Khan on 8/26/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "CLBaseSubscriber.h"
#import "CLAuthenticationController.h"
#import "CLAuthenticationEvent.h"

@interface CLAuthenticationSubscriber : CLBaseSubscriber

@property (nonatomic) CLAuthenticationController *authenticationController;

- (id)init;

@end