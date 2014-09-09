//
//  NPDateCell.m
//  Cooleaf
//
//  Created by Bazyli Zygan on 06.01.2014.
//  Copyright (c) 2014 Nova Project. All rights reserved.
//
#import <EventKit/EventKit.h>
#import "NPDateCell.h"

static UITextView *_tV;

@interface NPDateCell ()
{
    NSDate *_eventTime;
}
@property (weak, nonatomic) IBOutlet UILabel *dateTextView;

@end

@implementation NPDateCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDateString:(NSString *)dateString
{
    _dateString = dateString;
    
    NSDateFormatter *df1 = [NSDateFormatter new];
    NSDateFormatter *df2 = [NSDateFormatter new];
    NSDateFormatter *df3 = [NSDateFormatter new];
    df1.dateFormat = @"yyyy'-'MM'-'dd' 'HH':'mm':'ss' 'z";
    df1.locale = [NSLocale localeWithLocaleIdentifier:@"en_US"];
    df2.dateStyle = NSDateFormatterFullStyle;
    df2.timeStyle = NSDateFormatterNoStyle;
    df3.dateStyle = NSDateFormatterNoStyle;
    df3.timeStyle = NSDateFormatterShortStyle;
    
    _eventTime = [df1 dateFromString:dateString];
    _dateTextView.text = [NSString stringWithFormat:@"%@\n%@", [df2 stringFromDate:_eventTime], [df3 stringFromDate:_eventTime]];
    
    CGRect f = _dateTextView.frame;
    [_dateTextView sizeToFit];
    f.size.height = _dateTextView.frame.size.height;
    _dateTextView.frame = f;
    
}

- (IBAction)addTapped:(id)sender
{
    
    EKEventStore *eventStore = [[EKEventStore alloc] init];
    [eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
        if (granted)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                EKEvent *event  = [EKEvent eventWithEventStore:eventStore];
                event.title     = _title;
                
                event.startDate = _eventTime;
                event.endDate = [_eventTime dateByAddingTimeInterval:3600];
                
                EKCalendar *cal = [eventStore defaultCalendarForNewEvents];
                
                [event setCalendar:cal];
                
                NSError *err;
                BOOL save = [eventStore saveEvent:event span:EKSpanThisEvent commit:YES error:&err];
                
                UIAlertView *aV = nil;
                if (!err && save)
                    aV = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Event added", nil)
                                                    message:NSLocalizedString(@"Event has been added to your calendar", nil)
                                                   delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
                else
                    aV = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Error adding event", nil)
                                                    message:NSLocalizedString(@"You have no calendars created. Please create one and try again.", nil)
                                                   delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles:nil];
                [aV show];                
            });
        }
    }];

}

@end
