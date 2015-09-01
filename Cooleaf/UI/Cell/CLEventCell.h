//
//  CLEventCell.h
//  Cooleaf
//
//  Created by Haider Khan on 9/1/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CLEventCell;
@protocol CLEventCellDelegate <NSObject>

- (void)didPressJoin:(CLEventCell *)cell;
- (void)didPressComment:(CLEventCell *)cell;

@end

@interface CLEventCell : UITableViewCell

@property (nonatomic, assign) id<CLEventCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIView *eventView;
@property (weak, nonatomic) IBOutlet UITextView *eventDescription;

- (IBAction)join:(UIButton *)sender;
- (IBAction)comment:(UIButton *)sender;

@end
