//
//  UIColor+CustomColors.h
//  Cooleaf
//
//  Created by Haider Khan on 8/29/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (CustomColors)

+ (UIColor *)colorPrimary;
+ (UIColor *)colorPrimaryDark;
+ (UIColor *)colorAccent;
+ (UIColor *)navDrawerStart;
+ (UIColor *)navDrawerEnd;
+ (UIColor *)menuGradientFirstColor;
+ (UIColor *)menuGradientSecondColor;
+ (UIColor *)menuGradientThirdColor;
+ (UIColor *)menuGradientFourthColor;
+ (UIColor *)menuTextColor;
+ (UIColor *)UIColorFromRGB:(int)rgbValue;

@end
