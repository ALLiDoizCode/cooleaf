//
//  NPEventCell.m
//  Cooleaf
//
//  Created by Bazyli Zygan on 14.12.2013.
//  Copyright (c) 2013 Nova Project. All rights reserved.
//

#import "NPEventCell.h"
#import "NPCooleafClient.h"

@interface NPEventCell ()
{
    NSDateFormatter *_dateFormatter;
    NSDateFormatter *_dateFormatter2;
}
@property (weak, nonatomic) IBOutlet UIImageView *eventImage;
@property (weak, nonatomic) IBOutlet UITextView *eventTitle;
@property (weak, nonatomic) IBOutlet UILabel *eventDate;
@property (weak, nonatomic) IBOutlet UITextView *eventTags;

@end

@implementation NPEventCell

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

- (void)setEvent:(NSDictionary *)event
{
    _event = event;
    _eventTitle.text = _event[@"name"];
    
    if (!_dateFormatter)
    {
        _dateFormatter = [NSDateFormatter new];
        _dateFormatter.dateFormat = @"yyyy'-'MM'-'dd' 'HH':'mm':'ss' 'z";
    }
    NSDate *eventTime = [_dateFormatter dateFromString:_event[@"start_time"]];

    if (!_dateFormatter2)
    {
        _dateFormatter2 = [NSDateFormatter new];
        _dateFormatter2.dateStyle = NSDateFormatterLongStyle;
        _dateFormatter2.timeStyle = NSDateFormatterNoStyle;
    }
    
    _eventDate.text = [_dateFormatter2 stringFromDate:eventTime];
    
    NSMutableString *hashes = [NSMutableString string];
    for (NSString *hash in _event[@"categories_names"])
    {
        if (hashes.length > 0)
            [hashes appendFormat:@" #%@", hash];
        else
            [hashes appendFormat:@"#%@", hash];
    }
        
    NSString *imageUrlString = [@"http:" stringByAppendingString:[_event[@"image"][@"url"] stringByReplacingOccurrencesOfString:@"{{SIZE}}" withString:@"640x150"]];
    // Download image for event
    [[NPCooleafClient sharedClient] fetchImage:imageUrlString completion:^(NSString *imagePath, UIImage *image) {
       if ([imagePath compare:imageUrlString] == NSOrderedSame)
       {
           _eventImage.image = image;
       }
    }];
}

+ (CGFloat)cellHeightForEvent:(NSDictionary *)event
{
    return 274;
}

@end
