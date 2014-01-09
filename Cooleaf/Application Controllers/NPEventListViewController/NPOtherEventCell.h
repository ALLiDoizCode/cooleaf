//
//  NPOtherEventCell.h
//  Cooleaf
//
//  Created by Bazyli Zygan on 14.12.2013.
//  Copyright (c) 2013 Nova Project. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NPOtherEventCell : UITableViewCell <UIGestureRecognizerDelegate, UIActionSheetDelegate>

@property (nonatomic, setter = setEvent:) NSDictionary *event;
@property (nonatomic, setter = setLoading:) BOOL loading;
@property (nonatomic, copy) BOOL(^actionTapped)(NSNumber *eventId, BOOL join);

- (void)closeDrawer;
+ (CGFloat)cellHeightForEvent:(NSDictionary *)event;
@end
