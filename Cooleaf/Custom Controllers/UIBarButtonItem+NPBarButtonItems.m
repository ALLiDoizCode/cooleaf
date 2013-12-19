//
//  UIBarButtonItem+NPBarButtonItems.m
//  Cooleaf
//
//  Created by Bazyli Zygan on 05.08.2013.
//  Copyright (c) 2013 Nova Project. All rights reserved.
//

#import "UIBarButtonItem+NPBarButtonItems.h"

@implementation UIBarButtonItem (NPBarButtonItems)


+ (UIBarButtonItem *)buttonItemWithTitle:(NSString *)title target:(id)target selector:(SEL)selector
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.titleLabel.font = [UIFont fontWithName:@"AvenirNext-Medium" size:13];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor colorWithRed:40.0/255.0 green:179.0/255.0 blue:37.0/255.0 alpha:1]];
    btn.layer.cornerRadius = 4.0;
    [btn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    CGFloat width = [title sizeWithAttributes:@{NSFontAttributeName: btn.titleLabel.font}].width;
    
    btn.frame = CGRectMake(0, 0, width + 16, 28);
    
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}


@end
