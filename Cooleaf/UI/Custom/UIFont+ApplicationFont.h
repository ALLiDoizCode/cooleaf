//
//  UIFont+ApplicationFont.h
//  Cooleaf
//
//  Created by Bazyli Zygan on 19.12.2013.
//  Copyright (c) 2013 Nova Project. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFont (ApplicationFont)

+ (UIFont *)applicationFontOfSize:(CGFloat)size;
+ (UIFont *)boldApplicationFontOfSize:(CGFloat)size;
+ (UIFont *)mediumApplicationFontOfSize:(CGFloat)size;
@end
