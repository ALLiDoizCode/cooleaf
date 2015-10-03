//
//  CLPostView.m
//  Cooleaf
//
//  Created by Jonathan Green on 9/24/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "CLPostView.h"
#import "UIColor+CustomColors.h"

@implementation CLPostView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)layoutSubviews {
    
    if ([[UIScreen mainScreen] bounds].size.height >= 568 || [[UIScreen mainScreen] bounds].size.width >= 568 ) {
        //do nothing
    } else {
        //device = DEVICE_TYPE_IPHONE4 ;
        _cameraBtn.frame = CGRectMake(10, 425, 40, 40);
        _addImageBtn.frame = CGRectMake(270, 425, 40, 40);
        _imageView.frame = CGRectMake(_imageView.frame.origin.x + 80, 320, _imageView.frame.size.width/2, 65);
    }
}

-(void)awakeFromNib {
    
    _postTextView.delegate = self;
    _postTextView.editable = YES;
    
    [self buildView];
    [self buildTextView];
    [self buildLabel];
    [self buildButtons];
    [self buildImage];
    
    
}


-(void)buildView {
    
    _postView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    _postView.backgroundColor = [UIColor offWhite];
    
    
    /*_barView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.navigationController.navigationBar.bounds.size.height)];
    _barView.backgroundColor = [UIColor barWhite];*/
    
    //Border
    _border = [[UIView alloc] initWithFrame:CGRectMake(0,60, _postView.bounds.size.width, 0.5)];
    _border.backgroundColor = [UIColor lightGrayColor];
    
    [self addSubview:_postView];
    [_postView addSubview:_border];
    [_postView addSubview:_barView];
}

-(void)buildTextView {
    
    //TextView
    _postTextView = [[UITextView alloc] initWithFrame:CGRectMake(10, 115, _postView.bounds.size.width - 20, 190)];
    _postTextView.backgroundColor = [UIColor clearColor];
    _postTextView.font = [UIFont fontWithName:@"HelveticaNeue" size:15];
    CGPoint scrollPoint = _postTextView.contentOffset;
    scrollPoint.y= scrollPoint.y+40;
    [_postTextView setContentOffset:scrollPoint animated:YES];
    _postTextView.backgroundColor = [UIColor clearColor];
    _postTextView.delegate = self;
    [_postView addSubview:_postTextView];
    
    _postTextView.text = @"Enter your post...";
    _postTextView.textColor = [UIColor lightGrayColor];
}

-(void)buildLabel {
    
    //Title
    _labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(105, 30, 0, 0)];
    _labelTitle.textAlignment = NSTextAlignmentLeft;
    _labelTitle.text = @"Create a Post";
    _labelTitle.font = [UIFont fontWithName:@"HelveticaNeue" size:17];
    _labelTitle.backgroundColor = [UIColor clearColor];
    _labelTitle.textColor = [UIColor offBlack];
    [_labelTitle sizeToFit];
    _labelTitle.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    [_postView addSubview:_labelTitle];
    
    //Title
    _labelName = [[UILabel alloc] initWithFrame:CGRectMake(55, 80, 0, 0)];
    _labelName.textAlignment = NSTextAlignmentLeft;
    _labelName.text = @"Prem Bhatia";
    _labelName.font = [UIFont fontWithName:@"HelveticaNeue" size:12];
    _labelName.backgroundColor = [UIColor clearColor];
    _labelName.textColor = [UIColor offBlack];
    [_labelName sizeToFit];
    _labelName.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    
    [_postView addSubview:_labelName];
    
}

-(void)buildButtons {
    
    //cameraBtn
    _cameraBtn = [UIButton buttonWithType: UIButtonTypeRoundedRect];
    _cameraBtn.frame = CGRectMake(10, _postView.frame.size.height - 50, 40, 40);
    [_cameraBtn setTitle:@"Image" forState:UIControlStateNormal];
    [_cameraBtn setImage:[UIImage imageNamed:@"Camera"] forState:UIControlStateNormal];
    [_cameraBtn setTintColor:[UIColor grayColor]];
  
    
    //addImage
    _addImageBtn = [UIButton buttonWithType: UIButtonTypeRoundedRect];
    _addImageBtn.frame = CGRectMake(270, _postView.frame.size.height - 50, 40, 40);
    [_addImageBtn setTitle:@"Image" forState:UIControlStateNormal];
    [_addImageBtn setImage:[UIImage imageNamed:@"photo"] forState:UIControlStateNormal];
    [_addImageBtn setTintColor:[UIColor grayColor]];
    
    
    //Post
    _postBtn = [UIButton buttonWithType: UIButtonTypeRoundedRect];
    _postBtn.frame = CGRectMake(220, 30, 100, 18);
    [_postBtn setTitle:@"Post" forState:UIControlStateNormal];
    
    
    //Cancel
    _cancelBtn = [UIButton buttonWithType: UIButtonTypeRoundedRect];
    _cancelBtn.frame = CGRectMake(-5, 30, 100, 18);
    [_cancelBtn setTitle:@"Cancel" forState:UIControlStateNormal];
    
   
    
    [_postView addSubview:_postBtn];
    [_postView addSubview:_cancelBtn];
    [_postView addSubview:_cameraBtn];
    [_postView addSubview:_addImageBtn];
}

-(void)buildImage {
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 320, _postView.bounds.size.width - 20, 180)];
    _imageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    _imageView.image = [UIImage imageNamed:@"TestImage"];
    _imageView.layer.masksToBounds = YES;
    _imageView.layer.rasterizationScale = [UIScreen mainScreen].scale;
    _imageView.layer.shouldRasterize = YES;
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    _imageView.clipsToBounds = YES;
    _imageView.hidden = true;
    
    
    _imageIcon = [[UIImageView alloc] initWithFrame:CGRectMake(10, 70, 35, 35)];
    _imageIcon.layer.cornerRadius = _imageIcon.frame.size.height/2;
    _imageIcon.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    _imageIcon.image = [UIImage imageNamed:@"TestImage"];
    _imageIcon.layer.masksToBounds = YES;
    _imageIcon.layer.rasterizationScale = [UIScreen mainScreen].scale;
    _imageIcon.layer.shouldRasterize = YES;
    _imageIcon.clipsToBounds = YES;
    
    [_postView addSubview:_imageView];
    [_postView addSubview:_imageIcon];
}


@end
