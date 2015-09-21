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
@property (nonatomic) UILabel *labelSub;
@property (nonatomic) UILabel *labelCommentNum;
@property (nonatomic) UILabel *labelRewards;
@property (nonatomic) UILabel *labelPostName;
@property (nonatomic) UILabel *detailDescription;
@property (nonatomic) UILabel *titleDate;
@property (nonatomic) UILabel *labelDate;
@property (nonatomic) UILabel *labelEvent;
@property (nonatomic) UILabel *labelEventSub;
@property (nonatomic) UILabel *labelLocation;
@property (nonatomic) UIButton *members;
@property (nonatomic) UIButton *commentBtn;
@property (nonatomic) UIButton *joinBtn;
@property (nonatomic) UIScrollView *textScroll;
@end
