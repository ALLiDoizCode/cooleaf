//
//  NPEventSeriesDateCell.m
//  Cooleaf
//
//  Created by Dirk R on 4/5/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "NPEventSeriesDateCell.h"
#import "NPSeriesEvent.h"

static UIImage *gCheckboxOn;
static UIImage *gCheckboxOff;

@interface NPEventSeriesDateCell ()
{
	NPSeriesEvent *_npSeriesEvent;
//	UIImageView *_checkboxImg;
//	UILabel *_dateLabel;
	NSDateFormatter *_dateFormatter;

}
@property (weak, nonatomic) IBOutlet UIImageView *checkboxImg;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@end

@implementation NPEventSeriesDateCell

+ (void)load
{
	gCheckboxOn = [UIImage imageNamed:@"CheckboxChecked"];
	gCheckboxOff = [UIImage imageNamed:@"CheckboxUnchecked"];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setEventDate:(NPSeriesEvent *)npSeriesEvent
{
	_npSeriesEvent = npSeriesEvent;
	
	if (!_dateFormatter)
	{
		_dateFormatter = [NSDateFormatter new];
		_dateFormatter.dateStyle = NSDateFormatterLongStyle;
		_dateFormatter.timeStyle = NSDateFormatterShortStyle;
	}
	_dateLabel.text = [_dateFormatter stringFromDate:_npSeriesEvent.startTime];
	
	_checkboxImg.image = _npSeriesEvent.isAttending ? gCheckboxOn : gCheckboxOff;
	[_checkboxImg addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doActionToggleActive:)]];

	
}


- (void)doActionToggleAttending:(id)sender
{
	_npSeriesEvent.isAttending = !_npSeriesEvent.isAttending;
	_checkboxImg.image = _npSeriesEvent.isAttending ? gCheckboxOn : gCheckboxOff;
}



@end
