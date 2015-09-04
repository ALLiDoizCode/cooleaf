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
    //_groupImageView.image = _groupImageView.image;
    _mainImageView.contentMode = UIViewContentModeScaleAspectFill;
    _mainImageView.layer.masksToBounds = YES;
    _mainImageView.layer.rasterizationScale = [UIScreen mainScreen].scale;
    _mainImageView.layer.shouldRasterize = YES;
    _mainImageView.clipsToBounds = YES;
    
    /*//Icon Image
    UIImageView *IconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(525, 118, 20, 20)];
    IconImageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    IconImageView.image = [UIImage imageNamed:@"Particapant.png"];
    IconImageView.contentMode = UIViewContentModeScaleAspectFill;
    IconImageView.layer.masksToBounds = YES;
    IconImageView.layer.rasterizationScale = [UIScreen mainScreen].scale;
    IconImageView.layer.shouldRasterize = YES;
    IconImageView.clipsToBounds = YES;*/
    
    //Name
    _labelName = [[UILabel alloc] initWithFrame:CGRectMake(60, 255, 0, 0)];
    _labelName.textAlignment = NSTextAlignmentLeft;
    _labelName.text = @"#Prem Bhatia";
    _labelName.font = [UIFont fontWithName:@"HelveticaNeue" size:20];
    _labelName.backgroundColor = [UIColor clearColor];
    _labelName.textColor = offWhite;
    [_labelName sizeToFit];
    _labelName.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    
    //Post
    UIButton *postBtn = [UIButton buttonWithType: UIButtonTypeRoundedRect];
    postBtn.frame = CGRectMake(150, 315, 75, 30);
    [postBtn setTitle:@"Post" forState:UIControlStateNormal];
    postBtn.backgroundColor = [UIColor lightGrayColor];
    postBtn.layer.cornerRadius = 2;
    postBtn.layer.masksToBounds = YES;
    //[postBtn addTarget:self action:@selector(somefunc:) forControlEvents:UIControlEventTouchUpInside];
    
    //Join
    UIButton *joinBtn = [UIButton buttonWithType: UIButtonTypeRoundedRect];
    joinBtn.frame = CGRectMake(230, 315, 75, 30);
    [joinBtn setTitle:@"Join" forState:UIControlStateNormal];
    joinBtn.backgroundColor = [UIColor redColor];
    joinBtn.layer.cornerRadius = 2;
    joinBtn.layer.masksToBounds = YES;
     //[joinBtn addTarget:self action:@selector(somefunc:) forControlEvents:UIControlEventTouchUpInside];
    
    //Border
    UIView *border = [[UIView alloc] initWithFrame:CGRectMake(0, 400, bgview.frame.size.width, 0.5)];
    border.backgroundColor = [UIColor lightGrayColor];
    
    //Border2
    UIView *border2 = [[UIView alloc] initWithFrame:CGRectMake(0, 440, bgview.frame.size.width, 0.5)];
    border2.backgroundColor = [UIColor lightGrayColor];
    
    
    
    [self addSubview:bgview];
    [self addSubview:blur];
    [self addSubview:_labelName];
    [self addSubview:postBtn];
    [self addSubview:joinBtn];
    [self addSubview:border];
    [self addSubview:border2];
    [bgview addSubview:_mainImageView];
    
    
}

@end
