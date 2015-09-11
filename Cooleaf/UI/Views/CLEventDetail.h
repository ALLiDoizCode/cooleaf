//
//  CLEventDetail.h
//  Cooleaf
//
//  Created by Jonathan Green on 9/11/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CLEventDetail : UIView

@property (nonatomic) UIImageView *mainImageView;
@property (nonatomic) UILabel *labelName;
@property (nonatomic) UILabel *labelPostName;
@property (nonatomic) UILabel *detailDescription;
@property (nonatomic) UILabel *labelPost;
@property (nonatomic) UILabel *labelComment;
@property (nonatomic) UILabel *labelEvent;
@property (nonatomic) UILabel *labelEventSub;
@property (nonatomic) UIButton *members;
@property (nonatomic) UIButton *commentBtn;
@property (nonatomic) UIButton *joinBtn;

@end
