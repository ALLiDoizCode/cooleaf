//
//  NPInterestViewCell.m
//  Cooleaf
//
//  Created by Curtis Jones on 2015.03.12.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "NPInterestViewCell.h"
#import "NPInterest.h"

static UIImage *gCheckboxOn;
static UIImage *gCheckboxOff;

@interface NPInterestViewCell()
{
	NPInterest *_npinterest;
	UIImageView *_imageView;
	UIView *_footerView;
	UILabel *_titleLbl;
	UIImageView *_checkboxImg;
}
@end

@implementation NPInterestViewCell

+ (void)load
{
	gCheckboxOn = [UIImage imageNamed:@"CheckboxChecked"];
	gCheckboxOff = [UIImage imageNamed:@"CheckboxUnchecked"];
}

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
	self.backgroundColor = UIColor.blueColor;
	
	// interest image
	_imageView = [[UIImageView alloc] init];
	_imageView.translatesAutoresizingMaskIntoConstraints = FALSE;
	[self.contentView addSubview:_imageView];
	[self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_imageView attribute:NSLayoutAttributeTop    relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop   multiplier:1 constant:0]];
	[self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_imageView attribute:NSLayoutAttributeLeft   relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft  multiplier:1 constant:0]];
	[self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_imageView attribute:NSLayoutAttributeRight  relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
	[self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_imageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:_imageView       attribute:NSLayoutAttributeWidth multiplier:1 constant:0]];
	
	// footer rectangle
	_footerView = [[UIView alloc] init];
	_footerView.translatesAutoresizingMaskIntoConstraints = FALSE;
	_footerView.backgroundColor = UIColor.orangeColor;
	[self.contentView addSubview:_footerView];
	[self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_footerView attribute:NSLayoutAttributeTop    relatedBy:NSLayoutRelationEqual toItem:_imageView       attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
	[self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_footerView attribute:NSLayoutAttributeLeft   relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft   multiplier:1 constant:0]];
	[self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_footerView attribute:NSLayoutAttributeRight  relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight  multiplier:1 constant:0]];
	[self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_footerView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
	
	// interest title -- in the footer
	_titleLbl = [[UILabel alloc] init];
	_titleLbl.translatesAutoresizingMaskIntoConstraints = FALSE;
	_titleLbl.textAlignment = NSTextAlignmentLeft;
	_titleLbl.textColor = UIColor.whiteColor;
	[_footerView addSubview:_titleLbl];
	[_footerView addConstraint:[NSLayoutConstraint constraintWithItem:_titleLbl attribute:NSLayoutAttributeLeft    relatedBy:NSLayoutRelationEqual toItem:_footerView attribute:NSLayoutAttributeLeft    multiplier:1 constant: 10]];
	[_footerView addConstraint:[NSLayoutConstraint constraintWithItem:_titleLbl attribute:NSLayoutAttributeRight   relatedBy:NSLayoutRelationEqual toItem:_footerView attribute:NSLayoutAttributeRight   multiplier:1 constant:-10]];
	[_footerView addConstraint:[NSLayoutConstraint constraintWithItem:_titleLbl attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_footerView attribute:NSLayoutAttributeCenterY multiplier:1 constant:  0]];
	
	// interest enabled -- in the footer, visible when the cell is in edit mode
	_checkboxImg = [[UIImageView alloc] init];
	_checkboxImg.translatesAutoresizingMaskIntoConstraints = FALSE;
	_checkboxImg.userInteractionEnabled = TRUE;
	[_checkboxImg addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doActionToggleActive:)]];
	[_footerView addSubview:_checkboxImg];
	[_footerView addConstraint:[NSLayoutConstraint constraintWithItem:_checkboxImg attribute:NSLayoutAttributeLeft    relatedBy:NSLayoutRelationEqual toItem:_footerView attribute:NSLayoutAttributeLeft           multiplier:1 constant:10]];
	[_footerView addConstraint:[NSLayoutConstraint constraintWithItem:_checkboxImg attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_footerView attribute:NSLayoutAttributeCenterY        multiplier:1 constant: 0]];
	[_footerView addConstraint:[NSLayoutConstraint constraintWithItem:_checkboxImg attribute:NSLayoutAttributeWidth   relatedBy:NSLayoutRelationEqual toItem:nil         attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:20]];
	[_footerView addConstraint:[NSLayoutConstraint constraintWithItem:_checkboxImg attribute:NSLayoutAttributeHeight  relatedBy:NSLayoutRelationEqual toItem:nil         attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:20]];
}

- (void)setInterest:(NPInterest *)npinterest
{
	_npinterest = npinterest;
	_titleLbl.text = [@"# " stringByAppendingString:npinterest.name];
	[_npinterest image:^ (UIImage *image) { _imageView.image = image; }];
	
	if (_editModeOn == TRUE) {
		_checkboxImg.hidden = FALSE;
		_checkboxImg.image = _npinterest.isActive ? gCheckboxOn : gCheckboxOff;
		_titleLbl.textAlignment = NSTextAlignmentRight;
	}
	else {
		_checkboxImg.hidden = TRUE;
		_titleLbl.textAlignment = NSTextAlignmentLeft;
	}
}

- (void)doActionToggleActive:(id)sender
{
	_npinterest.isActive = !_npinterest.isActive;
	_checkboxImg.image = _npinterest.isActive ? gCheckboxOn : gCheckboxOff;
}

@end
