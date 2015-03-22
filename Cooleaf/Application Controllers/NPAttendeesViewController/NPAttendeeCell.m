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
    _avatarView.layer.masksToBounds = YES;
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
    
    if ([attendee[@"role"][@"department"][@"default"] boolValue])
    {
        if ([attendee[@"role"][@"branch"][@"default"] boolValue])
            _positionLabel.text = @"";
        else
            _positionLabel.text = [NSString stringWithFormat:@"%@\n\u00A0", attendee[@"role"][@"branch"][@"name"]];
    }
    else
    {
        if ([attendee[@"role"][@"branch"][@"default"] boolValue])
            _positionLabel.text = [NSString stringWithFormat:@"%@\n\u00A0", attendee[@"role"][@"department"][@"name"]];
        else
            _positionLabel.text = [NSString stringWithFormat:@"%@", attendee[@"role"][@"department"][@"name"]];
    }
    
    // Now - if no positionLabel content is there - we need to shift name
    _nameLabel.transform = (_positionLabel.text.length > 0) ? CGAffineTransformIdentity : CGAffineTransformMakeTranslation(0, 35);
    
    if (attendee[@"profile"][@"picture"][@"versions"][@"medium"])
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
