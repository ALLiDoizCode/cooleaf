//
//  UIColor+CustomColors.m
//  Cooleaf
//
//  Created by Haider Khan on 8/29/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "UIColor+CustomColors.h"

@implementation UIColor (CustomColors)

# pragma colorPrimary

+ (UIColor *)colorPrimary {
    return [UIColor colorWithRed:0.28 green:0.8 blue:0.77 alpha:1];
}


# pragma colorPrimaryDark

+ (UIColor *)colorPrimaryDark {
    return [UIColor colorWithRed:0.22 green:0.64 blue:0.61 alpha:1];
}


# pragma colorAccent

+ (UIColor *)colorAccent {
    return [UIColor colorWithRed:1 green:0.42 blue:0.4 alpha:1];
}


# pragma navDrawerStart

+ (UIColor *)navDrawerStart {
    return [UIColor colorWithRed:0.36 green:0.4 blue:0.5 alpha:1];
}


# pragma navDrawerEnd

+ (UIColor *)navDrawerEnd {
    return [UIColor colorWithRed:0.66 green:0.74 blue:0.85 alpha:1];
}

@end
