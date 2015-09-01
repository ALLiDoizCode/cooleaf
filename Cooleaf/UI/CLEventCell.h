//
//  CLEventCell.h
//  Cooleaf
//
//  Created by Haider Khan on 9/1/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CLEventCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *eventView;
@property (weak, nonatomic) IBOutlet UITextView *eventDescription;

@end
