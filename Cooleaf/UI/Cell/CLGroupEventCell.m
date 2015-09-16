//
//  CLGroupEventCell.m
//  Cooleaf
//
//  Created by Jonathan Green on 9/16/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "CLGroupEventCell.h"
#import <FXBlurView.h>
#import "UIColor+CustomColors.h"
#import "LabelWidth.h"

@implementation CLGroupEventCell


- (void)awakeFromNib {
    
    [LabelWidth labelWidth:_labelName];
    [LabelWidth labelWidth:_labelDate];
    
    UIColor *offWhite = [UIColor UIColorFromRGB:0xFDFDFD];
    
    //Background View
    UIView *bgview = [[UIView alloc] initWithFrame:CGRectMake(10, 30, 305, 160)];
    bgview.backgroundColor = [UIColor offWhite];
    
    //Blur
    FXBlurView *blur = [[FXBlurView alloc] initWithFrame:CGRectMake(20, 125, 285, 55)];
    blur.backgroundColor = [UIColor clearColor];
    blur.tintColor = [UIColor blackColor];
    blur.alpha = 0.7;
    
    
    //Image
    _eventImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10,10, bgview.frame.size.width - 20,bgview.frame.size.height - 20)];
    _eventImageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    _eventImageView.image = [UIImage imageNamed:@"TestImage"];
    _eventImageView.contentMode = UIViewContentModeScaleAspectFill;
    _eventImageView.layer.masksToBounds = YES;
    _eventImageView.layer.rasterizationScale = [UIScreen mainScreen].scale;
    _eventImageView.layer.shouldRasterize = YES;
    _eventImageView.clipsToBounds = YES;
    
    //Icon Image
    UIImageView *IconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(517, 130, 20, 20)];
    IconImageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    IconImageView.image = [UIImage imageNamed:@"events_icon"];
    IconImageView.contentMode = UIViewContentModeScaleAspectFill;
    IconImageView.layer.masksToBounds = YES;
    IconImageView.layer.rasterizationScale = [UIScreen mainScreen].scale;
    IconImageView.layer.shouldRasterize = YES;
    IconImageView.clipsToBounds = YES;
    
    //Name
    _labelName = [[UILabel alloc] initWithFrame:CGRectMake(90, 125, 0, 0)];
    _labelName.textAlignment = NSTextAlignmentLeft;
    _labelName.text = @"Name of event goes here";
    _labelName.numberOfLines = 0;
    _labelName.font = [UIFont fontWithName:@"HelveticaNeue" size:17];
    _labelName.backgroundColor = [UIColor clearColor];
    _labelName.textColor = offWhite;
    [_labelName sizeToFit];
    _labelName.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    
    //Count Label
    _labelRewards = [[UILabel alloc] initWithFrame:CGRectMake(460, 155, 0, 0)];
    _labelRewards.textAlignment = NSTextAlignmentLeft;
    _labelRewards.text = @"50 Reward Points";
    _labelRewards.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:11];
    _labelRewards.backgroundColor = [UIColor clearColor];
    _labelRewards.textColor = offWhite;
    [_labelRewards sizeToFit];
    _labelRewards.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    
    //Date Label
    _labelDate = [[UILabel alloc] initWithFrame:CGRectMake(62, 155, 0, 0)];
    _labelDate.textAlignment = NSTextAlignmentLeft;
    _labelDate.text = @"Dec 1, 2015";
    _labelDate.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:11];
    _labelDate.backgroundColor = [UIColor clearColor];
    _labelDate.textColor = offWhite;
    [_labelDate sizeToFit];
    _labelDate.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    
    
    [self.contentView addSubview:bgview];
    [bgview addSubview:_eventImageView];
    [self.contentView addSubview:blur];
    [self.contentView addSubview:_labelName];
    [self.contentView addSubview:_labelRewards];
    [self.contentView addSubview:_labelDate];
    [self.contentView addSubview:IconImageView];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end
