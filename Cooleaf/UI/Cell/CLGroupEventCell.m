//
//  CLGroupEventCell.m
//  Cooleaf
//
//  Created by Jonathan Green on 9/16/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "CLGroupEventCell.h"
#import "UIColor+CustomColors.h"
#import "LabelWidth.h"

@implementation CLGroupEventCell


- (void)awakeFromNib {
    
    self.mainImage.clipsToBounds = YES;
    self.bgView.backgroundColor = [UIColor offWhite];
    self.eventTitleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:14];
    self.eventTitleLabel.textColor = [UIColor offWhite];
    self.dateLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:11];
    self.dateLabel.textColor = [UIColor offWhite];
    self.rewardsLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:11];
    self.rewardsLabel.textColor = [UIColor offWhite];
    self.eventDescription.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:11];
    self.commentBtn.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:11];
    self.leaveBtn.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:11];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end
