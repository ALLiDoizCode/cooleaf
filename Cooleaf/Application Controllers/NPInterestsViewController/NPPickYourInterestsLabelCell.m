//
//  NPPickYourInterestsLabelCell.m
//  Cooleaf
//
//  Created by Dirk R on 4/4/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "NPPickYourInterestsLabelCell.h"

@interface NPPickYourInterestsLabelCell ()
{
	UIView *_topBarView;

}
@end

@implementation NPPickYourInterestsLabelCell

- (id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	
	if (self) {
		[self render];
	}
	
	return self;
}

- (void)render
{
	//self.backgroundColor = UIColor.blueColor;
	
	// top bar view
	_topBarView = [[UIView alloc] init];
	_topBarView.translatesAutoresizingMaskIntoConstraints = FALSE;
	_topBarView.backgroundColor = [UIColor whiteColor];
	_topBarView.layer.shadowColor = UIColor.blackColor.CGColor;
	_topBarView.layer.shadowOpacity = 0.5;
	_topBarView.layer.shadowOffset = CGSizeMake(0, 1);
	_topBarView.layer.shadowRadius = 1;
	[self.contentView addSubview:_topBarView];
	[self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[view]|" options:0 metrics:nil views:@{@"view": _topBarView}]];
	[self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[view]|" options:0 metrics:nil views:@{@"view": _topBarView}]];
	

		// "sign up" label
		UILabel *backLbl = [[UILabel alloc] init];
		backLbl.translatesAutoresizingMaskIntoConstraints = FALSE;
		backLbl.font = [UIFont mediumApplicationFontOfSize:15];
		backLbl.textColor = RGB(76, 205, 196);
		backLbl.text = @"Pick Some Interests Below";
		[_topBarView addSubview:backLbl];
		[_topBarView addConstraint:[NSLayoutConstraint constraintWithItem:backLbl attribute:NSLayoutAttributeLeft    relatedBy:NSLayoutRelationEqual toItem:_topBarView  attribute:NSLayoutAttributeLeft   multiplier:1 constant:12]];
		[_topBarView addConstraint:[NSLayoutConstraint constraintWithItem:backLbl attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_topBarView attribute:NSLayoutAttributeCenterY multiplier:1 constant: 0]];
	

}


@end
