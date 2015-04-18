//
//  NPAttendeesCell.m
//  Cooleaf
//
//  Created by Bazyli Zygan on 06.01.2014.
//  Copyright (c) 2014 Nova Project. All rights reserved.
//

#import "NPAttendeesCell.h"
#import "NPCooleafClient.h"

#define TAG_AVATAR 1001

@interface NPAttendeesCell ()

@property (weak, nonatomic) IBOutlet UILabel *noAttendeesLabel;
@property (weak, nonatomic) IBOutlet UILabel *attendeesLabel;
@property (weak, nonatomic) IBOutlet UIImageView *arrowView;

@end

@implementation NPAttendeesCell

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

- (void)prepareForReuse
{
    for (UIView *v in self.contentView.subviews)
    {
        if (v.tag == TAG_AVATAR)
            [v removeFromSuperview];
    }
    
    _attendeesLabel.text = @"";
    _noAttendeesLabel.hidden = YES;
    _attendeesLabel.hidden = NO;
    _arrowView.hidden = NO;
}

- (UIView *)avatarForUser:(NSDictionary *)user offset:(CGFloat)offset
{
    UIImageView *avatar = [[UIImageView alloc] initWithFrame:CGRectMake(15 + 30*offset, 11, 26, 26)];
    avatar.contentMode = UIViewContentModeScaleAspectFill;
    avatar.layer.cornerRadius = 13.0;
    avatar.clipsToBounds = YES;
    avatar.alpha = 0.6;
    avatar.tag = TAG_AVATAR;
    
    if (user)
    {
        if ([(NSString *)user[@"profile"][@"gender"] isEqualToString:@"m"])
            avatar.image = [UIImage imageNamed:@"AvatarPlaceholderMaleSmall"];
        else
            avatar.image = [UIImage imageNamed:@"AvatarPlaceholderFemaleSmall"];
        
        if (user[@"profile"][@"picture"][@"versions"][@"medium"])
        {
            NSURL *avatarURL = [[NPCooleafClient sharedClient].baseURL URLByAppendingPathComponent:user[@"profile"][@"picture"][@"versions"][@"small"]];
            [[NPCooleafClient sharedClient] fetchImage:avatarURL.absoluteString completion:^(NSString *imagePath, UIImage *image) {
                if (image && [imagePath isEqual:avatarURL.absoluteString])
                {
                    avatar.image = image;
                }
            }];
        }
        else
            avatar.alpha = 1.0;
    }
    else
    {
        avatar.image = [UIImage imageNamed:@"AvatarMore"];
        avatar.alpha = 1.0;
    }
    return avatar;
}

- (void)setAttendees:(NSArray *)attendees
{
    _attendees = [attendees copy];
    
    // Now we can add participants
    int avatarCount = 0;
    UIView *avatar = nil;
    // If we are participating - let's add us first
    if (_selfAttended)
    {
        avatar = [self avatarForUser:[NPCooleafClient sharedClient].userData offset:0];
        avatar.alpha = 1.0;
        [self.contentView addSubview:avatar];
        avatarCount = 1;
    }
    
    // Now all the rest
    for (int i = 0; i < ([_attendees count] > 5 ? 5 : [_attendees count]); i++)
    {
        // Skip ourselves
        if ([_attendees[i][@"id"] compare:[NPCooleafClient sharedClient].userData[@"id"]] == NSOrderedSame)
            continue;
        
        avatar = [self avatarForUser:_attendees[i] offset:avatarCount];
        [self.contentView addSubview:avatar];
        avatarCount++;
        
        if (avatarCount > 5)
        {
            avatar = [self avatarForUser:nil offset:avatarCount];
            [self.contentView addSubview:avatar];
            break;
        }
    }
    
    // Change the rest
    if ([_attendees count] > 0)
    {
        if (_attendees.count > 1)
            _attendeesLabel.text = [NSString stringWithFormat:NSLocalizedString(@"%ld attendees", nil), _attendeesCount];
        else
            _attendeesLabel.text = [NSString stringWithFormat:NSLocalizedString(@"%ld attendee", nil), _attendeesCount];
        _attendeesLabel.hidden = NO;
        _arrowView.hidden = NO;
        _noAttendeesLabel.hidden = YES;
    }
    else
    {
        _attendeesLabel.hidden = YES;
        _arrowView.hidden = YES;
        _noAttendeesLabel.hidden = NO;
    }
    

}

@end
