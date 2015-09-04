//
//  CLGroupCell.m
//  Cooleaf
//
//  Created by Jonathan Green on 9/4/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "CLGroupCell.h"

@implementation CLGroupCell

- (void)awakeFromNib {
   
    UIView *bgview = [[UIView alloc] initWithFrame:CGRectMake(20, 20, 285, 125)];
    bgview.backgroundColor = [UIColor redColor];
    
    _groupImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, bgview.frame.size.width,bgview.frame.size.height)];
    _groupImageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    _groupImageView.image = [UIImage imageNamed:@"TestImage"];
    _groupImageView.contentMode = UIViewContentModeScaleAspectFill;
    _groupImageView.layer.masksToBounds = YES;
    _groupImageView.layer.rasterizationScale = [UIScreen mainScreen].scale;
    _groupImageView.layer.shouldRasterize = YES;
    _groupImageView.clipsToBounds = YES;
    
    //Name
    _labelName = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, 0, 0)];
    _labelName.textAlignment = NSTextAlignmentLeft;
    _labelName.text = @"Prem Bhatia";
    _labelName.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
    _labelName.backgroundColor = [UIColor clearColor];
    _labelName.textColor = [UIColor grayColor];
    [_labelName sizeToFit];
    _labelName.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    
    
    [self.contentView addSubview:bgview];
    [bgview addSubview:_groupImageView];
    [bgview addSubview:_labelName];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
