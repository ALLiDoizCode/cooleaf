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
    
    
    
    [self addSubview:bgview];
    [self addSubview:blur];
    [self addSubview:_labelName];
    [bgview addSubview:_mainImageView];
    
    
}

@end
