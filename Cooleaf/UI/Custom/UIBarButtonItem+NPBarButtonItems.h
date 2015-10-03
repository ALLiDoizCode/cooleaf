//
//  UIBarButtonItem+NPBarButtonItems.h
//  Cooleaf
//
//  Created by Bazyli Zygan on 05.08.2013.
//  Copyright (c) 2013 Nova Project. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (NPBarButtonItems)

+ (UIBarButtonItem *)buttonItemWithTitle:(NSString *)title target:(id)target selector:(SEL)selector;

@end
