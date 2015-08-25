//
//  CLAuthenticationPresenter.h
//  Cooleaf
//
//  Created by Haider Khan on 8/25/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLAuthenticationPresenter : NSObject

- (void)authenticate:(NSString *)email :(NSString *)password;
- (void)addSelfAsObserver;
- (void)removeSelfAsObserver;

@end
