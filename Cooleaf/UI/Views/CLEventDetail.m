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
    [self labelWidth:_labelLocation];
    [self labelWidth:_labelDate];
    [self labelWidth:_labelLocation];
    [self labelWidth:_labelRewards];
    
    _detailDescription.frame = CGRectMake( _detailDescription.frame.origin.x,  _detailDescription.frame.origin.y, 285, 100);
    
    _detailDescription.numberOfLines = 0;
    
}


- (void)awakeFromNib {
    
    UIColor *offWhite = [UIColor offWhite];
    
    //Background View
    UIView *bgview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 300)];
    bgview.backgroundColor = [UIColor clearColor];
    
    UIScrollView *textScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 430, self.frame.size.width, 70)];
    
    //specify CGRect bounds in place of self.view.bounds to make it as a portion of parent view!
    textScroll.backgroundColor = [UIColor clearColor];
    textScroll.contentSize = CGSizeMake(textScroll.contentSize.width, _detailDescription.frame.size.height + 100);   //scroll view size
    textScroll.showsVerticalScrollIndicator = NO;    // to hide scroll indicators!
    textScroll.showsHorizontalScrollIndicator = YES; //by default, it shows!
    textScroll.scrollEnabled = YES;                 //say "NO" to disable scroll
    
    
    //Blur
    FXBlurView *blur = [[FXBlurView alloc] initWithFrame:CGRectMake(0, 190, self.frame.size.width, 110)];
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
    _labelEvent = [[UILabel alloc] initWithFrame:CGRectMake(10, 408, 0, 0)];
    _labelEvent.textAlignment = NSTextAlignmentLeft;
    _labelEvent.text = @"Description";
    _labelEvent.font = [UIFont fontWithName:@"HelveticaNeue" size:15];
    _labelEvent.backgroundColor = [UIColor clearColor];
    _labelEvent.textColor = [UIColor darkGrayColor];
    [_labelEvent sizeToFit];
    _labelEvent.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    
    //Title
    _labelName = [[UILabel alloc] initWithFrame:CGRectMake(10, 210, 300, 0)];
    _labelName.textAlignment = NSTextAlignmentLeft;
    _labelName.numberOfLines = 0;
    _labelName.text = @"#Prem Bhatia";
    _labelName.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:17];
    _labelName.backgroundColor = [UIColor clearColor];
    _labelName.textColor = [UIColor offWhite];
    [_labelName sizeToFit];
    _labelName.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    
    //subTitle
    _labelSub = [[UILabel alloc] initWithFrame:CGRectMake(10, 230, 300, 0)];
    _labelSub.textAlignment = NSTextAlignmentLeft;
    _labelSub.numberOfLines = 0;
    _labelSub.text = @"#Prem Bhatia";
    _labelSub.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:12];
    _labelSub.backgroundColor = [UIColor clearColor];
    _labelSub.textColor = [UIColor lightGrayColor];
    [_labelSub sizeToFit];
    _labelSub.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    
    //Comments Count
    _labelCommentNum = [[UILabel alloc] initWithFrame:CGRectMake(10, 270, 300, 0)];
    _labelCommentNum.textAlignment = NSTextAlignmentLeft;
    _labelCommentNum.numberOfLines = 0;
    _labelCommentNum.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:12];
    _labelCommentNum.backgroundColor = [UIColor clearColor];
    _labelCommentNum.textColor = [UIColor lightGrayColor];
    [_labelCommentNum sizeToFit];
    _labelCommentNum.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    
    //Rewards Count
    _labelRewards = [[UILabel alloc] initWithFrame:CGRectMake(240, 270, 300, 0)];
    _labelRewards.textAlignment = NSTextAlignmentLeft;
    _labelRewards.numberOfLines = 0;
    _labelRewards.text = @"0 Rewards";
    _labelRewards.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:12];
    _labelRewards.backgroundColor = [UIColor clearColor];
    _labelRewards.textColor = [UIColor lightGrayColor];
    [_labelRewards sizeToFit];
    _labelRewards.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    
    //Description
    _detailDescription = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 200, 0)];
    _detailDescription.numberOfLines = 2;
    _detailDescription.textAlignment = NSTextAlignmentLeft;
    _detailDescription.text = @"Position";
    _detailDescription.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
    _detailDescription.backgroundColor = [UIColor clearColor];
    _detailDescription.textColor = [UIColor darkGrayColor];
    [_detailDescription sizeToFit];
    _detailDescription.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    _detailDescription.lineBreakMode = UILineBreakModeWordWrap;
    
    //Date Label
    _titleDate = [[UILabel alloc] initWithFrame:CGRectMake(10, 510, 300, 0)];
    _titleDate.numberOfLines = 0;
    _titleDate.textAlignment = NSTextAlignmentLeft;
    _titleDate.text = @"Date";
    _titleDate.font = [UIFont fontWithName:@"HelveticaNeue" size:15];
    _titleDate.backgroundColor = [UIColor clearColor];
    _titleDate.textColor = [UIColor darkGrayColor];
    [_titleDate sizeToFit];
    _titleDate.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    
    //Date text Label
    _labelDate = [[UILabel alloc] initWithFrame:CGRectMake(10, 540, 300, 0)];
    _labelDate.numberOfLines = 0;
    _labelDate.textAlignment = NSTextAlignmentLeft;
    _labelDate.text = @"8/19/15";
    _labelDate.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
    _labelDate.backgroundColor = [UIColor clearColor];
    _labelDate.textColor = [UIColor darkGrayColor];
    [_labelDate sizeToFit];
    _labelDate.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    
    //Location Label
    _labelLocation = [[UILabel alloc] initWithFrame:CGRectMake(10,560, 250,45)];
    _labelLocation.numberOfLines = 0;
    _labelLocation.textAlignment = NSTextAlignmentLeft;
    _labelLocation.text = @"Location";
    _labelLocation.font = [UIFont fontWithName:@"HelveticaNeue" size:15];
    _labelLocation.backgroundColor = [UIColor clearColor];
    _labelLocation.textColor = [UIColor darkGrayColor];
    [_labelLocation sizeToFit];
    _labelLocation.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    
    //Comment
    _commentBtn = [UIButton buttonWithType: UIButtonTypeRoundedRect];
    _commentBtn.frame = CGRectMake(150, 315, 75, 30);
    [_commentBtn setTitle:@"COMMENTS" forState:UIControlStateNormal];
    _commentBtn.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:11];
    _commentBtn.backgroundColor = [UIColor commentButtonColor];
    _commentBtn.tintColor = [UIColor darkGrayColor];
    _commentBtn.layer.cornerRadius = 2;
    _commentBtn.layer.masksToBounds = YES;
    //[_postBtn addTarget:self action:@selector(somefunc:) forControlEvents:UIControlEventTouchUpInside];
    
    //Join
    _joinBtn = [UIButton buttonWithType: UIButtonTypeRoundedRect];
    _joinBtn.frame = CGRectMake(230, 315, 75, 30);
    [_joinBtn setTitle:@"JOIN" forState:UIControlStateNormal];
    _joinBtn.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:11];
    _joinBtn.backgroundColor = [UIColor eventColor];
    _joinBtn.tintColor = offWhite;
    _joinBtn.layer.cornerRadius = 2;
    _joinBtn.layer.masksToBounds = YES;
    //[joinBtn addTarget:self action:@selector(somefunc:) forControlEvents:UIControlEventTouchUpInside];
    
    //Members
    _participantsButton = [UIButton buttonWithType: UIButtonTypeRoundedRect];
    _participantsButton.frame  = CGRectMake(230, 380, 80, 10);
    _participantsButton.font = [UIFont fontWithName:@"HelveticaNeue" size:10];
    [_participantsButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    //[members addTarget:self action:@selector(somefunc:) forControlEvents:UIControlEventTouchUpInside];
    
    //Member icon
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
    
    [textScroll addSubview:_detailDescription];
    [self addSubview:bgview];
    [self addSubview:textScroll];
    [self addSubview:blur];
    [self addSubview:_labelName];
    [self addSubview:_labelSub];
    [self addSubview:_labelPostName];
    [self addSubview:_titleDate];
    [self addSubview:_labelDate];
    [self addSubview:_labelRewards];
    [self addSubview:_labelCommentNum];
    [self addSubview:_labelEvent];
    [self addSubview:_labelEventSub];
    [self addSubview:_participantsButton];
    [self addSubview:_commentBtn];
    [self addSubview:_joinBtn];
    [self addSubview:_labelLocation];
    [self addSubview:border];
    [self addSubview:border2];
    [bgview addSubview:_mainImageView];
}

-(void)labelWidth:(UILabel *)theLabel {
    
    // use this for custom font
    // CGFloat width =  [theLabel.text sizeWithFont:[UIFont fontWithName:@"ChaparralPro-Bold" size:40 ]].width;
    
    // Use this for system font
    CGFloat width =  [theLabel.text sizeWithFont:[UIFont systemFontOfSize:40 ]].width;
    theLabel.frame = CGRectMake(theLabel.frame.origin.x, theLabel.frame.origin.y, width, theLabel.frame.size.height);
    
    // point.x, point.y -> origin for label;
    // height -> your label height;
}


@end
