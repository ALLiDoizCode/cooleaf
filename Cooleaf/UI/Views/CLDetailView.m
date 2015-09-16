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
    
    //Name
    _labelName = [[UILabel alloc] initWithFrame:CGRectMake(60, 255, 0, 0)];
    _labelName.textAlignment = NSTextAlignmentLeft;
    _labelName.text = @"#Prem Bhatia";
    _labelName.font = [UIFont fontWithName:@"HelveticaNeue" size:20];
    _labelName.backgroundColor = [UIColor clearColor];
    _labelName.textColor = [UIColor offWhite];
    [_labelName sizeToFit];
    _labelName.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    
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
    _postBtn2.frame = CGRectMake(90, 408, 78, 25);
    [_postBtn2 setTitle:@"Posts" forState:UIControlStateNormal];
    _postBtn2.backgroundColor = [UIColor offWhite];
    _postBtn2.tintColor = [UIColor darkGrayColor];
    _postBtn2.layer.cornerRadius = 3;
    _postBtn2.layer.borderWidth = 1.5;
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
    _eventBtn.layer.borderWidth = 1.5;
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
    [bgview addSubview:_mainImageView];
}

@end
