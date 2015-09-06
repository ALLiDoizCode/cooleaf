//
//  CLEventCell.m
//  Cooleaf
//
//  Created by Haider Khan on 9/1/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "CLEventCell.h"

@implementation CLEventCell

- (IBAction)join:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(didPressJoin:)]) {
        [self.delegate didPressJoin:self];
    }
}

- (IBAction)comment:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(didPressComment:)]) {
        [self.delegate didPressComment:self];
    }
}

@end
