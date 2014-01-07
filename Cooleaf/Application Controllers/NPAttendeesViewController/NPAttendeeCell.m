//
//  NPAttendeeCell.m
//  Cooleaf
//
//  Created by Bazyli Zygan on 07.01.2014.
//  Copyright (c) 2014 Nova Project. All rights reserved.
//

#import "NPAttendeeCell.h"
#import "NPCooleafClient.h"

@interface NPAttendeeCell ()

@property (weak, nonatomic) IBOutlet UIImageView *avatarView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *positionLabel;

@end

@implementation NPAttendeeCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    _avatarView.layer.cornerRadius = 22.0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setAttendee:(NSDictionary *)attendee
{
    _attendee = attendee;
    
    if (!_attendee)
    {
        return;
    }
    
    _nameLabel.text = attendee[@"name"];
    if ([attendee[@"profile"][@"gender"] isEqualToString:@"f"])
    {
        _avatarView.image = [UIImage imageNamed:@"AvatarPlaceholderFemaleMedium"];
    }
    else
    {
        _avatarView.image = [UIImage imageNamed:@"AvatarPlaceholderMaleMedium"];
    }
    
    _positionLabel.text = [NSString stringWithFormat:@"%@\n%@", attendee[@"role"][@"department"][@"name"], attendee[@"role"][@"organization"][@"name"]];
    if (attendee[@"profile"][@"picture"][@"original"])
    {
        NSURL *avatarURL = [[NPCooleafClient sharedClient].baseURL URLByAppendingPathComponent:attendee[@"profile"][@"picture"][@"versions"][@"medium"]];
        [[NPCooleafClient sharedClient] fetchImage:avatarURL.absoluteString completion:^(NSString *imagePath, UIImage *image) {
            if (image && [imagePath isEqual:avatarURL.absoluteString])
            {
                _avatarView.image = image;
            }
        }];
    }
    
}

@end