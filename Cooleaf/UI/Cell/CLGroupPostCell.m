//
//  CLGroupPostCell.m
//  Cooleaf
//
//  Created by Jonathan Green on 9/4/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "CLGroupPostCell.h"
#import "UIColor+CustomColors.h"

@implementation CLGroupPostCell

- (void)awakeFromNib {
    
    
    UIColor *offWhite = [UIColor UIColorFromRGB:0xFDFDFD];
    
    //Background View
    UIView *bgview = [[UIView alloc] initWithFrame:CGRectMake(10, 20, 295, 150)];
    bgview.backgroundColor = offWhite;
    
    /// member Icon
    UIImageView *PostImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 35, 35)];
    PostImage.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    PostImage.image = [UIImage imageNamed:@"TestImage"];
    PostImage.layer.masksToBounds = YES;
    PostImage.layer.cornerRadius = PostImage.frame.size.height/2;
    PostImage.layer.borderColor = [UIColor clearColor].CGColor;
    PostImage.layer.borderWidth = 3.0f;
    PostImage.layer.rasterizationScale = [UIScreen mainScreen].scale;
    PostImage.layer.shouldRasterize = YES;
    
    
    //Count Label
    _labelCount = [[UILabel alloc] initWithFrame:CGRectMake(260, 10, 0, 0)];
    _labelCount.textAlignment = NSTextAlignmentLeft;
    _labelCount.text = @"1hr";
    _labelCount.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
    _labelCount.backgroundColor = [UIColor clearColor];
    _labelCount.textColor = [UIColor darkGrayColor];
    [_labelCount sizeToFit];
    _labelCount.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    
    //Name
    _labelPostName = [[UILabel alloc] initWithFrame:CGRectMake(60, 10, 35, 35)];
    _labelPostName.textAlignment = NSTextAlignmentLeft;
    _labelPostName.text = @"Prem Bhatia";
    _labelPostName.font = [UIFont fontWithName:@"HelveticaNeue" size:13];
    _labelPostName.backgroundColor = [UIColor clearColor];
    _labelPostName.textColor = [UIColor darkGrayColor];
    [_labelPostName sizeToFit];
    _labelPostName.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    
    
    //postion
    _labelPostName2 = [[UILabel alloc] initWithFrame:CGRectMake(60, 30, 35, 35)];
    _labelPostName2.textAlignment = NSTextAlignmentLeft;
    _labelPostName2.text = @"Position";
    _labelPostName2.font = [UIFont fontWithName:@"HelveticaNeue" size:13];
    _labelPostName2.backgroundColor = [UIColor clearColor];
    _labelPostName2.textColor = [UIColor lightGrayColor];
    [_labelPostName2 sizeToFit];
    _labelPostName2.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    
    //Post Label
    _labelPost = [[UILabel alloc] initWithFrame:CGRectMake(10, 60, 270, 0)];
    _labelPost.numberOfLines = 0;
    _labelPost.textAlignment = NSTextAlignmentLeft;
    _labelPost.text = @"We should eventually read classic books, like the one about the boy and his dog.";
    _labelPost.font = [UIFont fontWithName:@"HelveticaNeue" size:13];
    _labelPost.backgroundColor = [UIColor clearColor];
    _labelPost.textColor = [UIColor darkGrayColor];
    [_labelPost sizeToFit];
    _labelPost.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    
   //Post Label
    _labelComment = [[UILabel alloc] initWithFrame:CGRectMake(10, 320, 60, 0)];
    _labelComment.numberOfLines = 0;
    _labelComment.textAlignment = NSTextAlignmentLeft;
    _labelComment.text = @"6 comments";
    _labelComment.font = [UIFont fontWithName:@"HelveticaNeue" size:10];
    _labelComment.backgroundColor = [UIColor clearColor];
    _labelComment.textColor = [UIColor lightGrayColor];
    [_labelComment sizeToFit];
    _labelComment.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    
    
    [self.contentView addSubview:bgview];
    [bgview addSubview:_labelCount];
    [bgview addSubview:PostImage];
    [bgview addSubview:_labelPostName];
    [bgview addSubview:_labelPostName2];
    [bgview addSubview:_labelPost];
    [bgview addSubview:_labelComment];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
