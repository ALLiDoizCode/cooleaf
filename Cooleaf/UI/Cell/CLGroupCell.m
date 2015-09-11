//
//  CLGroupCell.m
//  Cooleaf
//
//  Created by Jonathan Green on 9/4/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "CLGroupCell.h"
#import <FXBlurView.h>
#import "UIColor+CustomColors.h"

@implementation CLGroupCell

- (void)awakeFromNib {
    
    
    UIColor *offWhite = [UIColor UIColorFromRGB:0xFDFDFD];
    
    //Background View
    UIView *bgview = [[UIView alloc] initWithFrame:CGRectMake(18, 20, 285, 125)];
    bgview.backgroundColor = [UIColor clearColor];
    
    //Blur
    FXBlurView *blur = [[FXBlurView alloc] initWithFrame:CGRectMake(18, 105, 285, 40)];
    blur.backgroundColor = [UIColor clearColor];
    blur.tintColor = [UIColor blackColor];
    blur.alpha = 0.7;
    
    
    //Image
    _groupImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, bgview.frame.size.width,bgview.frame.size.height)];
    _groupImageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    //_groupImageView.image = _groupImageView.image;
    _groupImageView.contentMode = UIViewContentModeScaleAspectFill;
    _groupImageView.layer.masksToBounds = YES;
    _groupImageView.layer.rasterizationScale = [UIScreen mainScreen].scale;
    _groupImageView.layer.shouldRasterize = YES;
    _groupImageView.clipsToBounds = NO;
    
    //Icon Image
   UIImageView *IconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(505, 118, 20, 20)];
   IconImageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    IconImageView.image = [UIImage imageNamed:@"Particapant.png"];
    IconImageView.contentMode = UIViewContentModeScaleAspectFill;
    IconImageView.layer.masksToBounds = YES;
    IconImageView.layer.rasterizationScale = [UIScreen mainScreen].scale;
    IconImageView.layer.shouldRasterize = YES;
    IconImageView.clipsToBounds = YES;
    
    //Name
    _labelName = [[UILabel alloc] initWithFrame:CGRectMake(68, 120, 0, 0)];
    _labelName.textAlignment = NSTextAlignmentLeft;
    _labelName.text = @"#Prem Bhatia";
    _labelName.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
    _labelName.backgroundColor = [UIColor clearColor];
    _labelName.textColor = offWhite;
    [_labelName sizeToFit];
    _labelName.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    
    //Count Label
    _labelCount = [[UILabel alloc] initWithFrame:CGRectMake(458, 120, 0, 0)];
    _labelCount.textAlignment = NSTextAlignmentLeft;
    _labelCount.text = @"11";
    _labelCount.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
    _labelCount.backgroundColor = [UIColor clearColor];
    _labelCount.textColor = offWhite;
    [_labelCount sizeToFit];
    _labelCount.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    
    
    [self.contentView addSubview:bgview];
    [self.contentView addSubview:blur];
    [self.contentView addSubview:_labelName];
    [self.contentView addSubview:_labelCount];
    [self.contentView addSubview:IconImageView];
    [bgview addSubview:_groupImageView];
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
