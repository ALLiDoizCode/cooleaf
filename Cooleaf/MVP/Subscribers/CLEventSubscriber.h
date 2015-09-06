//
//  CLEventSubscriber.h
//  Cooleaf
//
//  Created by Haider Khan on 8/26/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "CLBaseSubscriber.h"
#import "CLEventController.h"

@interface CLEventSubscriber : CLBaseSubscriber

@property (nonatomic) CLEventController *eventController;

- (id)init;

@end