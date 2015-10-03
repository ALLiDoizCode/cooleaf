//
//  CLPostView.h
//  Cooleaf
//
//  Created by Jonathan Green on 9/24/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CLPostView : UIView

@property(nonatomic)UIView *postView;
@property(nonatomic)UITextView *postTextView;
@property(nonatomic)UIImageView *imageView;
@property(nonatomic)UIButton *cameraBtn;
@property(nonatomic)UIButton *addImageBtn;
@property(nonatomic)UIImageView *imageIcon;
@property(nonatomic)UIButton *cancelBtn;
@property(nonatomic)UIButton *postBtn;
@property(nonatomic)UILabel *labelName;
@property(nonatomic)UILabel *labelTitle;
@property(nonatomic)UIView *barView;
@property(nonatomic)UIView *border;



@end
