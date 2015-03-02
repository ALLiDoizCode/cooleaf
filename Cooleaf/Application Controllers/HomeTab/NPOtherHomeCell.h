//
//  NPOtherHomeCell.h
//  Cooleaf
//
//  Created by Dirk R on 3/1/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NPOtherHomeCell : UITableViewCell<UIGestureRecognizerDelegate, UIActionSheetDelegate>

@property (nonatomic, setter = setEvent:) NSDictionary *event;
@property (nonatomic, setter = setLoading:) BOOL loading;
@property (nonatomic, copy) BOOL(^actionTapped)(NSNumber *eventId, BOOL join);

- (void)closeDrawer;
+ (CGFloat)cellHeightForEvent:(NSDictionary *)event;
@end
