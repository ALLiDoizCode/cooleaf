//
//  CLCheckRegistrationEvent.h
//  Cooleaf
//
//  Created by Haider Khan on 9/29/15.
//  Copyright © 2015 Nova Project. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLCheckRegistrationEvent : NSObject

@property (nonatomic, assign) NSString *email;

- (id)initWithEmail:(NSString *)email;

@end
