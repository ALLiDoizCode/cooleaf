//
//  CLAuthenticationPresenter.m
//  Cooleaf
//
//  Created by Haider Khan on 8/25/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "CLAuthenticationPresenter.h"

@implementation CLAuthenticationPresenter

- (void)authenticate:(NSString *)email :(NSString *)password {
    
}


- (void)addSelfAsObserver {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@"authenticate" name:@"" object:nil];
}



@end
