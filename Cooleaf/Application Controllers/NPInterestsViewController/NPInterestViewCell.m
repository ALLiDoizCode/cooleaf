//
//  NPInterestViewCell.m
//  Cooleaf
//
//  Created by Curtis Jones on 2015.03.12.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "NPInterestViewCell.h"

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
}

@end
