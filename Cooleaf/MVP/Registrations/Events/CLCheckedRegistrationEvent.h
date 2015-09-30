//
//  CLCheckedRegistrationEvent.h
//  Cooleaf
//
//  Created by Haider Khan on 9/29/15.
//  Copyright © 2015 Nova Project. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CLRegistration.h"

@interface CLCheckedRegistrationEvent : NSObject

@property (nonatomic, assign) CLRegistration *registration;

- (id)initWithRegistration:(CLRegistration *)registration;

@end
