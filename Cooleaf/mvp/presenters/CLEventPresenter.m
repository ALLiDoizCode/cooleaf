//
//  CLEventPresenter.m
//  Cooleaf
//
//  Created by Haider Khan on 8/25/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "CLEventPresenter.h"

@implementation CLEventPresenter


-(void)loadEvents {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"loadEvents" object:nil];
}

@end
