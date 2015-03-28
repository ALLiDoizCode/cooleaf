//
//  NPMemberCell.m
//  Cooleaf
//
//  Created by Dirk R on 3/28/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "NPMemberCell.h"
#import "NPCooleafClient.h"

@interface NPMemberCell ()

@property (weak, nonatomic) IBOutlet UIImageView *avatarView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *positionLabel;

@end

@implementation NPMemberCell

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
	
	if (_positionLabel.text.length > 0)
		_positionLabel.hidden = TRUE;
	else
		_positionLabel.hidden = FALSE;
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
