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
	[self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[view]|" options:0 metrics:nil views:@{@"view": _imageView}]];
	[self.contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[view]|" options:0 metrics:nil views:@{@"view": _imageView}]];
}

- (void)setInterest:(NPInterest *)npinterest
{
	_npinterest = npinterest;
	
	[_npinterest image:^ (UIImage *image) {
		_imageView.image = image;
	}];
}

@end
