//
//  CLDetailView.h
//  Cooleaf
//
//  Created by Jonathan Green on 9/4/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CLDetailView;
@protocol CLDetailViewDelegate <NSObject>

- (void)selectSegment:(CLDetailView *)detailView;

@end

@interface CLDetailView : UIView

@property (nonatomic, assign) id<CLDetailViewDelegate> delegate;
@property (nonatomic, strong) UISegmentedControl *segmentedControl;
@property (nonatomic, strong) UIImageView *mainImageView;
@property (nonatomic, strong) UILabel *labelName;
@property (nonatomic, strong) UILabel *labelEvent;
@property (nonatomic, strong) UILabel *labelEventSub;
@property (nonatomic, strong) UIButton *members;
@property (nonatomic, strong) UIButton *postBtn;
@property (nonatomic, strong) UIButton *joinBtn;
@property (nonatomic, strong) UIButton *postBtn2;
@property (nonatomic, strong) UIButton *eventBtn;

@end
