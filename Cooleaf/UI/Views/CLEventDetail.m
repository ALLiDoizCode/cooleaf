//
//  CLEventDetail.m
//  Cooleaf
//
//  Created by Jonathan Green on 9/11/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "CLEventDetail.h"
#import "UIColor+CustomColors.h"
#import <FXBlurView.h>

@implementation CLEventDetail

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)layoutSubviews {
    
    [self labelWidth:_labelName];
    
    _detailDescription.frame = CGRectMake( _detailDescription.frame.origin.x,  _detailDescription.frame.origin.y, 200, 100);
    
    _detailDescription.numberOfLines = 0;
    
}


- (void)awakeFromNib {
    
    UIColor *offWhite = [UIColor UIColorFromRGB:0xFDFDFD];
    
    //Background View
    UIView *bgview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 300)];
    bgview.backgroundColor = [UIColor clearColor];
    
    //Blur
    FXBlurView *blur = [[FXBlurView alloc] initWithFrame:CGRectMake(0, 235, self.frame.size.width, 65)];
    blur.backgroundColor = [UIColor clearColor];
    blur.tintColor = [UIColor blackColor];
    blur.alpha = 0.85;
    
    
    //Image
    _mainImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0, bgview.frame.size.width,bgview.frame.size.height)];
    _mainImageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    _mainImageView.contentMode = UIViewContentModeScaleAspectFill;
    _mainImageView.layer.masksToBounds = YES;
    _mainImageView.layer.rasterizationScale = [UIScreen mainScreen].scale;
    _mainImageView.layer.shouldRasterize = YES;
    _mainImageView.clipsToBounds = YES;
    
    
    //Event label
    _labelEvent = [[UILabel alloc] initWithFrame:CGRectMake(40, 408, 0, 0)];
    _labelEvent.textAlignment = NSTextAlignmentLeft;
    _labelEvent.text = @"Events";
    _labelEvent.font = [UIFont fontWithName:@"HelveticaNeue" size:15];
    _labelEvent.backgroundColor = [UIColor clearColor];
    _labelEvent.textColor = [UIColor lightGrayColor];
    [_labelEvent sizeToFit];
    _labelEvent.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    
    
    //Title
    _labelName = [[UILabel alloc] initWithFrame:CGRectMake(60, 255, 300, 0)];
    _labelName.textAlignment = NSTextAlignmentLeft;
    _labelName.numberOfLines = 0;
    _labelName.text = @"#Prem Bhatia";
    _labelName.font = [UIFont fontWithName:@"HelveticaNeue" size:17];
    _labelName.backgroundColor = [UIColor clearColor];
    _labelName.textColor = [UIColor offWhite];
    [_labelName sizeToFit];
    _labelName.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    
    
    
    //Name
    _detailDescription = [[UILabel alloc] initWithFrame:CGRectMake(40, 400, 200, 0)];
    _detailDescription.numberOfLines = 0;
    _detailDescription.textAlignment = NSTextAlignmentLeft;
    _detailDescription.text = @"Position";
    //_detailDescription.preferredMaxLayoutWidth = 200;
    //[_detailDescription setPreferredMaxLayoutWidth:YES];
    _detailDescription.font = [UIFont fontWithName:@"HelveticaNeue" size:13];
    _detailDescription.backgroundColor = [UIColor clearColor];
    _detailDescription.textColor = [UIColor lightGrayColor];
    [_detailDescription sizeToFit];
    _detailDescription.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    //_detailDescription.clipsToBounds = YES;
    
    //Post Label
    _labelPost = [[UILabel alloc] initWithFrame:CGRectMake(120, 505, 300, 0)];
    _labelPost.numberOfLines = 0;
    _labelPost.textAlignment = NSTextAlignmentLeft;
    _labelPost.text = @"We should eventually read classic books, like the one about the boy and his dog.";
    _labelPost.font = [UIFont fontWithName:@"HelveticaNeue" size:13];
    _labelPost.backgroundColor = [UIColor clearColor];
    _labelPost.textColor = [UIColor darkGrayColor];
    [_labelPost sizeToFit];
    _labelPost.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    
    //Post Label
    _labelComment = [[UILabel alloc] initWithFrame:CGRectMake(25, 545, 300, 0)];
    _labelComment.numberOfLines = 0;
    _labelComment.textAlignment = NSTextAlignmentLeft;
    _labelComment.text = @"6 comments";
    _labelComment.font = [UIFont fontWithName:@"HelveticaNeue" size:10];
    _labelComment.backgroundColor = [UIColor clearColor];
    _labelComment.textColor = [UIColor lightGrayColor];
    [_labelComment sizeToFit];
    _labelComment.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    
    //Comment
    _commentBtn = [UIButton buttonWithType: UIButtonTypeRoundedRect];
    _commentBtn.frame = CGRectMake(150, 315, 75, 30);
    [_commentBtn setTitle:@"COMMENTS" forState:UIControlStateNormal];
    _commentBtn.font = [UIFont fontWithName:@"HelveticaNeue" size:11];
    _commentBtn.backgroundColor = [UIColor UIColorFromRGB:0xE0E1E4];
    _commentBtn.tintColor = [UIColor darkGrayColor];
    _commentBtn.layer.cornerRadius = 2;
    _commentBtn.layer.masksToBounds = YES;
    //[_postBtn addTarget:self action:@selector(somefunc:) forControlEvents:UIControlEventTouchUpInside];
    
    //Join
    _joinBtn = [UIButton buttonWithType: UIButtonTypeRoundedRect];
    _joinBtn.frame = CGRectMake(230, 315, 75, 30);
    [_joinBtn setTitle:@"JOIN" forState:UIControlStateNormal];
    _joinBtn.font = [UIFont fontWithName:@"HelveticaNeue" size:11];
    _joinBtn.backgroundColor = [UIColor UIColorFromRGB:0x00BCD5];
    _joinBtn.tintColor = offWhite;
    _joinBtn.layer.cornerRadius = 2;
    _joinBtn.layer.masksToBounds = YES;
    //[joinBtn addTarget:self action:@selector(somefunc:) forControlEvents:UIControlEventTouchUpInside];
    
    //Members
    _members = [UIButton buttonWithType: UIButtonTypeRoundedRect];
    _members.frame  = CGRectMake(230, 380, 70, 10);
    [_members setTitle:@"5 Participants>" forState:UIControlStateNormal];
    _members.font = [UIFont fontWithName:@"HelveticaNeue" size:10];
    [_members setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    //[members addTarget:self action:@selector(somefunc:) forControlEvents:UIControlEventTouchUpInside];
    
    /// member Icon
    UIImageView *memberImage = [[UIImageView alloc] initWithFrame:CGRectMake(20, 355, 40, 40)];
    memberImage.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    memberImage.image = [UIImage imageNamed:@"TestImage"];
    memberImage.layer.masksToBounds = YES;
    memberImage.layer.cornerRadius = memberImage.frame.size.height/2;
    memberImage.layer.borderColor = [UIColor clearColor].CGColor;
    memberImage.layer.borderWidth = 3.0f;
    memberImage.layer.rasterizationScale = [UIScreen mainScreen].scale;
    memberImage.layer.shouldRasterize = YES;
    
    
    
    //Border
    UIView *border = [[UIView alloc] initWithFrame:CGRectMake(0, 400, bgview.frame.size.width, 0.5)];
    border.backgroundColor = [UIColor lightGrayColor];
    
    //Border2
    UIView *border2 = [[UIView alloc] initWithFrame:CGRectMake(0, 500, bgview.frame.size.width, 0.5)];
    border2.backgroundColor = [UIColor lightGrayColor];
    
    
    
    [self addSubview:bgview];
    [self addSubview:blur];
    [self addSubview:_labelName];
    [self addSubview:_labelPostName];
    [self addSubview:_detailDescription];
    [self addSubview:_labelPost];
    [self addSubview:_labelComment];
    [self addSubview:_labelEvent];
    [self addSubview:_labelEventSub];
    [self addSubview:_members];
    [self addSubview:_commentBtn];
    [self addSubview:_joinBtn];
    [self addSubview:border];
    [self addSubview:border2];
    //[self addSubview:memberImage];
    [bgview addSubview:_mainImageView];
    
    
}

-(void)labelWidth:(UILabel *)theLabel {
    
    //use this for custom font
    //CGFloat width =  [theLabel.text sizeWithFont:[UIFont fontWithName:@"ChaparralPro-Bold" size:40 ]].width;
    
    //use this for system font
    CGFloat width =  [theLabel.text sizeWithFont:[UIFont systemFontOfSize:40 ]].width;
    
    theLabel.frame = CGRectMake(theLabel.frame.origin.x, theLabel.frame.origin.y, width, theLabel.frame.size.height);
    
    //point.x, point.y -> origin for label;
    //height -> your label height;
}

@end
