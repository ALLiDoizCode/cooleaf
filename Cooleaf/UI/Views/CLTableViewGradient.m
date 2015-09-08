//
//  CLTableViewGradient.m
//  Cooleaf
//
//  Created by Jonathan Green on 9/1/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "CLTableViewGradient.h"
#import "UIColor+CustomColors.h"

@implementation CLTableViewGradient


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGGradientRef gradient;
    CGColorSpaceRef colorspace;
    CGFloat locations[4] = { 0.9,0.8,0.7,0.3};
    
    UIColor *myColor1 = [UIColor menuGradientFirstColor];
    UIColor *myColor2 = [UIColor menuGradientSecondColor];
    UIColor *myColor3 = [UIColor menuGradientThirdColor];
    
    NSArray *colors = @[(id)myColor1.CGColor,
                        (id)myColor1.CGColor,
                        (id)myColor2.CGColor,
                        (id)myColor3.CGColor];
    
    colorspace = CGColorSpaceCreateDeviceRGB();
    
    gradient = CGGradientCreateWithColors(colorspace,
                                          (CFArrayRef)colors, locations);
    
    CGPoint startPoint, endPoint;
    startPoint.x = -200;
    startPoint.y = 400;
    
    endPoint.x = 300;
    endPoint.y = 0;
    
    CGContextDrawLinearGradient(context, gradient,
                                startPoint, endPoint, 0);
}


@end
