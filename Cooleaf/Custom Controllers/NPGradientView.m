//
//  NPGradientView.m
//  Cooleaf
//
//  Created by Bazyli Zygan on 19.12.2013.
//  Copyright (c) 2013 Nova Project. All rights reserved.
//

#import "NPGradientView.h"

@implementation NPGradientView

+ (CAGradientLayer*) whiteGradient {
    
    UIColor *colorOne = [UIColor colorWithWhite:1.0 alpha:0.0];
    UIColor *colorTwo = [UIColor colorWithWhite:1.0 alpha:1.0];
    
    NSArray *colors =  [NSArray arrayWithObjects:(id)colorOne.CGColor, colorTwo.CGColor, nil];
    
    NSNumber *stopOne = [NSNumber numberWithFloat:0.0];
    NSNumber *stopTwo = [NSNumber numberWithFloat:0.5];
    
    NSArray *locations = [NSArray arrayWithObjects:stopOne, stopTwo, nil];
    CAGradientLayer *headerLayer = [CAGradientLayer layer];
    headerLayer.colors = colors;
    headerLayer.locations = locations;

    return headerLayer;
}

- (void)awakeFromNib
{
    self.backgroundColor = [UIColor clearColor];
    CAGradientLayer *fL = [NPGradientView whiteGradient];
    fL.frame = self.bounds;
    [self.layer addSublayer:fL];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self awakeFromNib];
    }
    return self;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
