//
//  NPEventCell.h
//  Cooleaf
//
//  Created by Bazyli Zygan on 14.12.2013.
//  Copyright (c) 2013 Nova Project. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NPEventCell : UITableViewCell <UIGestureRecognizerDelegate>

@property (nonatomic, setter = setEvent:) NSDictionary *event;

+ (CGFloat)cellHeightForEvent:(NSDictionary *)event;
@end
