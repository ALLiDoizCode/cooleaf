//
//  CLGroupPostCell.m
//  Cooleaf
//
//  Created by Jonathan Green on 9/4/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "CLGroupPostCell.h"
#import "UIColor+CustomColors.h"
#import "LabelWidth.h"

@implementation CLGroupPostCell


-(void)layoutSubviews {
    
    //self.contentView.frame = CGRectMake( self.contentView.frame.origin.x + 40,  self.contentView.frame.origin.y, self.contentView.frame.size.width - 300, self.contentView.frame.size.height - 25);
    //self.contentView.backgroundColor = [UIColor redColor];
   
}

- (void)awakeFromNib {
  
   
    
    //Background View
    //UIView *bgview = [[UIView alloc] initWithFrame:CGRectMake(13, 20, 295, 150)];
    //bgview.backgroundColor = [UIColor offWhite];
    
    // User Icon
   // _userImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 35, 35)];
    _userImage.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    _userImage.layer.masksToBounds = YES;
    _userImage.layer.cornerRadius = _userImage.frame.size.height/2;
    _userImage.layer.borderColor = [UIColor clearColor].CGColor;
    _userImage.layer.borderWidth = 3.0f;
    _userImage.layer.rasterizationScale = [UIScreen mainScreen].scale;
    _userImage.layer.shouldRasterize = YES;
    
    
    //Count Label
   // _labelCount = [[UILabel alloc] initWithFrame:CGRectMake(260, 10, 0, 0)];
    _labelCount.textAlignment = NSTextAlignmentLeft;
    _labelCount.text = @"1hr";
    _labelCount.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
    _labelCount.backgroundColor = [UIColor clearColor];
    _labelCount.textColor = [UIColor darkGrayColor];
    [_labelCount sizeToFit];
    _labelCount.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    
    //Name
   // _labelPostName = [[UILabel alloc] initWithFrame:CGRectMake(60, 10, 35, 35)];
    _labelPostName.textAlignment = NSTextAlignmentLeft;
    _labelPostName.text = @"Prem Bhatia";
    _labelPostName.font = [UIFont fontWithName:@"HelveticaNeue" size:13];
    _labelPostName.backgroundColor = [UIColor clearColor];
    _labelPostName.textColor = [UIColor darkGrayColor];
    [_labelPostName sizeToFit];
    _labelPostName.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    [LabelWidth labelWidth:_labelPostName];
    
    
    //postion
   // _labelPostName2 = [[UILabel alloc] initWithFrame:CGRectMake(60, 30, 35, 35)];
    _labelPostName2.textAlignment = NSTextAlignmentLeft;
    _labelPostName2.text = @"Position";
    _labelPostName2.font = [UIFont fontWithName:@"HelveticaNeue" size:13];
    _labelPostName2.backgroundColor = [UIColor clearColor];
    _labelPostName2.textColor = [UIColor lightGrayColor];
    [_labelPostName2 sizeToFit];
    _labelPostName2.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    [LabelWidth labelWidth:_labelPostName2];
    
    //Post Label
   // _labelPost = [[UILabel alloc] initWithFrame:CGRectMake(10, 60, 270, 0)];
    _labelPost.numberOfLines = 0;
    _labelPost.textAlignment = NSTextAlignmentLeft;
    _labelPost.text = @"We should eventually read classic books, like the one about the boy and his dog.";
    _labelPost.font = [UIFont fontWithName:@"HelveticaNeue" size:13];
    _labelPost.backgroundColor = [UIColor clearColor];
    _labelPost.textColor = [UIColor darkGrayColor];
    [_labelPost sizeToFit];
    _labelPost.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    
    //postion
   // _commentLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 130, 35, 35)];
    _commentLabel.textAlignment = NSTextAlignmentLeft;
    _commentLabel.text = @"6 comments";
    _commentLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:10];
    _commentLabel.backgroundColor = [UIColor clearColor];
    _commentLabel.textColor = [UIColor lightGrayColor];
    [_commentLabel sizeToFit];
    _commentLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    
    //[self.contentView addSubview:bgview];
    //[bgview addSubview:_labelCount];
    //[bgview addSubview:_userImage];
    //[bgview addSubview:_labelPostName];
    //[bgview addSubview:_labelPostName2];
    //[bgview addSubview:_labelPost];
    //[bgview addSubview:_commentLabel];
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
