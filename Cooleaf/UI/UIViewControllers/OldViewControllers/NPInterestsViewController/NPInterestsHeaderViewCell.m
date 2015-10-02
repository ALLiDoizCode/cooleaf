//
//  NPInterestsHeaderViewCell.m
//  Cooleaf
//
//  Created by Curtis Jones on 2015.03.17.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "NPInterestsHeaderViewCell.h"

@interface NPInterestsHeaderViewCell ()
{
	/**
	 * Top bar
	 */
	UIView *_topBarView;
	UIView *_backBtn;
	UIView *_nextBtn;
	
}
@end

@implementation NPInterestsHeaderViewCell

- (id)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	
	if (self) {
		[self render];
	}
	
	return self;
}

- (void)render {
	
	// top bar view
	_topBarView = [[UIView alloc] init];
	_topBarView.translatesAutoresizingMaskIntoConstraints = FALSE;
	_topBarView.backgroundColor = RGB(0x31, 0xCB, 0xC2);
	_topBarView.layer.shadowColor = UIColor.blackColor.CGColor;
	_topBarView.layer.shadowOpacity = 0.5;
	_topBarView.layer.shadowOffset = CGSizeMake(0, 1);
	_topBarView.layer.shadowRadius = 1;
	[self.contentView addSubview:_topBarView];
	[self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[view]|" options:0 metrics:nil views:@{@"view": _topBarView}]];
	[self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[view]|" options:0 metrics:nil views:@{@"view": _topBarView}]];
	
	// back button
	{
		// view
		_backBtn = [[UIView alloc] init];
		_backBtn.translatesAutoresizingMaskIntoConstraints = FALSE;
		_backBtn.userInteractionEnabled = TRUE;
		[_backBtn addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doActionBack:)]];
		[_topBarView addSubview:_backBtn];
		[_topBarView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[view(100)]" options:0 metrics:nil views:@{@"view": _backBtn}]];
		[_topBarView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[view]|" options:0 metrics:nil views:@{@"view": _backBtn}]];
		
		// left arrow
		UIImageView *backImg = [[UIImageView alloc] init];
		backImg.translatesAutoresizingMaskIntoConstraints = FALSE;
		backImg.image = [[UIImage imageNamed:@"AccessoryArrow"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
		backImg.tintColor = UIColor.whiteColor;
		backImg.transform = CGAffineTransformMakeRotation(M_PI);
		[_backBtn addSubview:backImg];
		[_backBtn addConstraint:[NSLayoutConstraint constraintWithItem:backImg attribute:NSLayoutAttributeLeft    relatedBy:NSLayoutRelationEqual toItem:_backBtn attribute:NSLayoutAttributeLeft           multiplier:1 constant:16]];
		[_backBtn addConstraint:[NSLayoutConstraint constraintWithItem:backImg attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_backBtn attribute:NSLayoutAttributeCenterY        multiplier:1 constant: 0]];
		[_backBtn addConstraint:[NSLayoutConstraint constraintWithItem:backImg attribute:NSLayoutAttributeWidth   relatedBy:NSLayoutRelationEqual toItem:nil      attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:13]];
		[_backBtn addConstraint:[NSLayoutConstraint constraintWithItem:backImg attribute:NSLayoutAttributeHeight  relatedBy:NSLayoutRelationEqual toItem:nil      attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:22]];
		
		// "sign up" label
		UILabel *backLbl = [[UILabel alloc] init];
		backLbl.translatesAutoresizingMaskIntoConstraints = FALSE;
		backLbl.font = [UIFont mediumApplicationFontOfSize:15];
		backLbl.textColor = UIColor.whiteColor;
		backLbl.text = @"BASIC INFO";
		[_backBtn addSubview:backLbl];
		[_backBtn addConstraint:[NSLayoutConstraint constraintWithItem:backLbl attribute:NSLayoutAttributeLeft    relatedBy:NSLayoutRelationEqual toItem:backImg  attribute:NSLayoutAttributeRight   multiplier:1 constant:12]];
		[_backBtn addConstraint:[NSLayoutConstraint constraintWithItem:backLbl attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_backBtn attribute:NSLayoutAttributeCenterY multiplier:1 constant: 0]];
	}
	
	// next button
	{
		// view
		_nextBtn = [[UIView alloc] init];
		_nextBtn.translatesAutoresizingMaskIntoConstraints = FALSE;
		_nextBtn.userInteractionEnabled = TRUE;
		[_nextBtn addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doActionNext:)]];
		[_topBarView addSubview:_nextBtn];
		[_topBarView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[view(100)]|" options:0 metrics:nil views:@{@"view": _nextBtn}]];
		[_topBarView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[view]|" options:0 metrics:nil views:@{@"view": _nextBtn}]];
		
		// "next" label
		UILabel *nextLbl = [[UILabel alloc] init];
		nextLbl.translatesAutoresizingMaskIntoConstraints = FALSE;
		nextLbl.font = [UIFont mediumApplicationFontOfSize:16];
		nextLbl.textColor = UIColor.whiteColor;
		nextLbl.text = @"NEXT";
		[_nextBtn addSubview:nextLbl];
		[_nextBtn addConstraint:[NSLayoutConstraint constraintWithItem:nextLbl attribute:NSLayoutAttributeRight   relatedBy:NSLayoutRelationEqual toItem:_nextBtn attribute:NSLayoutAttributeRight   multiplier:1 constant:-16]];
		[_nextBtn addConstraint:[NSLayoutConstraint constraintWithItem:nextLbl attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_nextBtn attribute:NSLayoutAttributeCenterY multiplier:1 constant:  0]];
	}
}

- (void)doActionBack:(id)sender {
	DLog(@"");
    NSLog(@"back action inside cell");
	if (_backHandler)
		_backHandler();
}

- (void)doActionNext:(id)sender {
	DLog(@"");
    NSLog(@"next action inside cell");
	if (_nextHandler)
		_nextHandler();
}

@end
