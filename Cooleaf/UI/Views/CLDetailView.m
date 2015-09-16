//
//  CLDetailView.m
//  Cooleaf
//
//  Created by Jonathan Green on 9/4/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "CLDetailView.h"
#import "UIColor+CustomColors.h"
#import <FXBlurView.h>

@implementation CLDetailView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)awakeFromNib {
    
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
    //_groupImageView.image = _groupImageView.image;
    _mainImageView.contentMode = UIViewContentModeScaleAspectFill;
    _mainImageView.layer.masksToBounds = YES;
    _mainImageView.layer.rasterizationScale = [UIScreen mainScreen].scale;
    _mainImageView.layer.shouldRasterize = YES;
    _mainImageView.clipsToBounds = YES;
    
    //send Icon
    
    UIImageView *sendIcon = [[UIImageView alloc] initWithFrame:CGRectMake(20, 410, 25, 25)];
    sendIcon.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    sendIcon.image = [UIImage imageNamed:@"send.png"];
    sendIcon.contentMode = UIViewContentModeScaleAspectFill;
    sendIcon.layer.masksToBounds = YES;
    sendIcon.layer.rasterizationScale = [UIScreen mainScreen].scale;
    sendIcon.layer.shouldRasterize = YES;
    sendIcon.clipsToBounds = YES;
    
    //Name
    _labelName = [[UILabel alloc] initWithFrame:CGRectMake(60, 255, 0, 0)];
    _labelName.textAlignment = NSTextAlignmentLeft;
    _labelName.text = @"#Prem Bhatia";
    _labelName.font = [UIFont fontWithName:@"HelveticaNeue" size:20];
    _labelName.backgroundColor = [UIColor clearColor];
    _labelName.textColor = [UIColor offWhite];
    [_labelName sizeToFit];
    _labelName.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    
    //Name
    _labelPostName = [[UILabel alloc] initWithFrame:CGRectMake(120, 460, 0, 0)];
    _labelPostName.textAlignment = NSTextAlignmentLeft;
    _labelPostName.text = @"Prem Bhatia";
    _labelPostName.font = [UIFont fontWithName:@"HelveticaNeue" size:13];
    _labelPostName.backgroundColor = [UIColor clearColor];
    _labelPostName.textColor = [UIColor darkGrayColor];
    [_labelPostName sizeToFit];
    _labelPostName.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    
    
    //Name
    _labelPostName2 = [[UILabel alloc] initWithFrame:CGRectMake(120, 480, 0, 0)];
    _labelPostName2.textAlignment = NSTextAlignmentLeft;
    _labelPostName2.text = @"Position";
    _labelPostName2.font = [UIFont fontWithName:@"HelveticaNeue" size:13];
    _labelPostName2.backgroundColor = [UIColor clearColor];
    _labelPostName2.textColor = [UIColor lightGrayColor];
    [_labelPostName2 sizeToFit];
    _labelPostName2.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    
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
    
    //Post
    _postBtn = [UIButton buttonWithType: UIButtonTypeRoundedRect];
    _postBtn.frame = CGRectMake(150, 315, 75, 30);
    [_postBtn setTitle:@"POST" forState:UIControlStateNormal];
    _postBtn.backgroundColor = [UIColor postButtonColor];
    _postBtn.tintColor = [UIColor darkGrayColor];
    _postBtn.layer.cornerRadius = 2;
    _postBtn.layer.masksToBounds = YES;
    //[_postBtn addTarget:self action:@selector(somefunc:) forControlEvents:UIControlEventTouchUpInside];
    
    //Join
    _joinBtn = [UIButton buttonWithType: UIButtonTypeRoundedRect];
    _joinBtn.frame = CGRectMake(230, 315, 75, 30);
    [_joinBtn setTitle:@"JOIN" forState:UIControlStateNormal];
    _joinBtn.backgroundColor = [UIColor groupNavBarColor];
    _joinBtn.tintColor = [UIColor offWhite];
    _joinBtn.layer.cornerRadius = 2;
    _joinBtn.layer.masksToBounds = YES;
     //[joinBtn addTarget:self action:@selector(somefunc:) forControlEvents:UIControlEventTouchUpInside];
    
    
    //Post2
    _postBtn2 = [UIButton buttonWithType: UIButtonTypeRoundedRect];
    _postBtn2.frame = CGRectMake(90, 408, 80, 25);
    [_postBtn2 setTitle:@"Posts" forState:UIControlStateNormal];
    _postBtn2.backgroundColor = [UIColor offWhite];
    _postBtn2.tintColor = [UIColor darkGrayColor];
    _postBtn2.layer.cornerRadius = 3;
    _postBtn2.layer.borderWidth = 2;
    _postBtn2.layer.borderColor = [UIColor darkGrayColor].CGColor;
    _postBtn2.layer.masksToBounds = YES;
    //[_postBtn2 addTarget:self action:@selector(somefunc:) forControlEvents:UIControlEventTouchUpInside];
    
    //Join
    _eventBtn = [UIButton buttonWithType: UIButtonTypeRoundedRect];
    _eventBtn.frame = CGRectMake(162, 408, 75, 25);
    [_eventBtn setTitle:@"Events" forState:UIControlStateNormal];
    _eventBtn.backgroundColor = [UIColor darkGrayColor];
    _eventBtn.tintColor = [UIColor offWhite];
    _eventBtn.layer.cornerRadius = 3;
    _eventBtn.layer.borderWidth = 2;
    _eventBtn.layer.borderColor = [UIColor darkGrayColor].CGColor;
    
    
    _eventBtn.layer.masksToBounds = YES;
    //[_eventBtn addTarget:self action:@selector(somefunc:) forControlEvents:UIControlEventTouchUpInside];
    
    //Members
    _members = [UIButton buttonWithType: UIButtonTypeRoundedRect];
    _members.frame  = CGRectMake(230, 380, 60, 10);
    [_members setTitle:@"5 Members>" forState:UIControlStateNormal];
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
    
    /// post Icon
    UIImageView *postImage = [[UIImageView alloc] initWithFrame:CGRectMake(20, 455, 40, 40)];
    postImage.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    postImage.image = [UIImage imageNamed:@"TestImage"];
    postImage.layer.masksToBounds = YES;
    postImage.layer.cornerRadius = postImage.frame.size.height/2;
    postImage.layer.borderColor = [UIColor clearColor].CGColor;
    postImage.layer.borderWidth = 3.0f;
    postImage.layer.rasterizationScale = [UIScreen mainScreen].scale;
    postImage.layer.shouldRasterize = YES;
    
    //Border
    UIView *border = [[UIView alloc] initWithFrame:CGRectMake(0, 400, bgview.frame.size.width, 0.5)];
    border.backgroundColor = [UIColor lightGrayColor];
    
    //Border2
    UIView *border2 = [[UIView alloc] initWithFrame:CGRectMake(0, 440, bgview.frame.size.width, 0.5)];
    border2.backgroundColor = [UIColor lightGrayColor];
    
    [self addSubview:bgview];
    [self addSubview:blur];
    [self addSubview:_labelName];
    [self addSubview:_labelEvent];
    [self addSubview:_labelEventSub];
    [self addSubview:_members];
    [self addSubview:_postBtn];
    [self addSubview:_joinBtn];
    [self addSubview:_postBtn2];
    [self addSubview:_eventBtn];
    [self addSubview:border];
    [self addSubview:border2];
    [self addSubview:memberImage];
    [bgview addSubview:_mainImageView];
}

@end
