//
//  CLInterestSuscriber.h
//  Cooleaf
//
//  Created by Haider Khan on 8/26/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "CLBaseSubscriber.h"
#import "CLInterestController.h"

@interface CLInterestSubscriber : CLBaseSubscriber

@property (nonatomic) CLInterestController *interestController;

- (id)init;

@end