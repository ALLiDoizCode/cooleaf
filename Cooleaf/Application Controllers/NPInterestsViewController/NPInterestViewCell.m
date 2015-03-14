//
//  NPInterestViewCell.m
//  Cooleaf
//
//  Created by Curtis Jones on 2015.03.12.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "NPInterestViewCell.h"
#import "NPInterest.h"

@interface NPInterestViewCell()
{
	NPInterest *_npinterest;
	UIImageView *_imageView;
	UIView *_footerView;
	UILabel *_titleLbl;
}
@end

@implementation NPInterestViewCell

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
	
	_imageView = [[UIImageView alloc] init];
	_imageView.translatesAutoresizingMaskIntoConstraints = FALSE;
	[self.contentView addSubview:_imageView];
	[self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_imageView attribute:NSLayoutAttributeTop    relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop   multiplier:1 constant:0]];
	[self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_imageView attribute:NSLayoutAttributeLeft   relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft  multiplier:1 constant:0]];
	[self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_imageView attribute:NSLayoutAttributeRight  relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight multiplier:1 constant:0]];
	[self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_imageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:_imageView       attribute:NSLayoutAttributeWidth multiplier:1 constant:0]];
	
	_footerView = [[UIView alloc] init];
	_footerView.translatesAutoresizingMaskIntoConstraints = FALSE;
	_footerView.backgroundColor = UIColor.orangeColor;
	[self.contentView addSubview:_footerView];
	[self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_footerView attribute:NSLayoutAttributeTop    relatedBy:NSLayoutRelationEqual toItem:_imageView       attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
	[self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_footerView attribute:NSLayoutAttributeLeft   relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeft   multiplier:1 constant:0]];
	[self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_footerView attribute:NSLayoutAttributeRight  relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeRight  multiplier:1 constant:0]];
	[self.contentView addConstraint:[NSLayoutConstraint constraintWithItem:_footerView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
	
	_titleLbl = [[UILabel alloc] init];
	_titleLbl.translatesAutoresizingMaskIntoConstraints = FALSE;
	_titleLbl.textAlignment = NSTextAlignmentLeft;
	_titleLbl.textColor = UIColor.whiteColor;
	[_footerView addSubview:_titleLbl];
	[_footerView addConstraint:[NSLayoutConstraint constraintWithItem:_titleLbl attribute:NSLayoutAttributeLeft    relatedBy:NSLayoutRelationEqual toItem:_footerView attribute:NSLayoutAttributeLeft    multiplier:1 constant:10]];
	[_footerView addConstraint:[NSLayoutConstraint constraintWithItem:_titleLbl attribute:NSLayoutAttributeRight   relatedBy:NSLayoutRelationEqual toItem:_footerView attribute:NSLayoutAttributeRight   multiplier:1 constant: 0]];
	[_footerView addConstraint:[NSLayoutConstraint constraintWithItem:_titleLbl attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_footerView attribute:NSLayoutAttributeCenterY multiplier:1 constant: 0]];
}

- (void)setInterest:(NPInterest *)npinterest
{
	_npinterest = npinterest;
	
	_titleLbl.text = [@"# " stringByAppendingString:npinterest.name];
	[_npinterest image:^ (UIImage *image) { _imageView.image = image; }];
}

@end
