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
}
@property (weak, nonatomic) IBOutlet UIImageView *eventImage;
@property (weak, nonatomic) IBOutlet UILabel *eventTitle;
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
    }
    NSDate *eventTime = [_dateFormatter dateFromString:_event[@"start_time"]];
    NSLog(@"Date is %@", eventTime);
    
    NSMutableString *hashes = [NSMutableString string];
    for (NSString *hash in _event[@"categories_names"])
    {
        if (hashes.length > 0)
            [hashes appendFormat:@" #%@", hash];
        else
            [hashes appendFormat:@"#%@", hash];
    }
    
    _eventTags.text = hashes;
    _eventTags.font = [UIFont boldSystemFontOfSize:14];
    _eventTags.textColor = [UIColor colorWithRed:153.0/255.0 green:153.0/255.0 blue:153.0/255.0 alpha:1];
    _eventTags.textAlignment = NSTextAlignmentRight;
    
    NSString *imageUrlString = [_event[@"image"] stringByReplacingOccurrencesOfString:@"{{SIZE}}" withString:@"640x350"];
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
