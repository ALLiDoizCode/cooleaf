//
//  NPCompanyCell.m
//  Cooleaf
//
//  Created by Bazyli Zygan on 24.01.2014.
//  Copyright (c) 2014 Nova Project. All rights reserved.
//

#import "NPCompanyCell.h"
#import "NPCooleafClient.h"

@interface NPCompanyCell ()

@property (weak, nonatomic) IBOutlet UIImageView *avatarView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *logoView;
@end

@implementation NPCompanyCell

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
    NSDictionary *uD = [NPCooleafClient sharedClient].userData;
    if (!uD)
        return;
    NSURL *companyBannerURL = [[NPCooleafClient sharedClient].baseURL URLByAppendingPathComponent:uD[@"role"][@"organization"][@"logo"][@"versions"][@"thumb"]];
    [[NPCooleafClient sharedClient] fetchImage:companyBannerURL.absoluteString completion:^(NSString *imagePath, UIImage *image) {
        if (image && [imagePath isEqualToString:companyBannerURL.absoluteString])
        {
            _logoView.image = image;
            CGSize imgSize = image.size;
            imgSize.width = imgSize.width * 28 / imgSize.height;
            imgSize.height = 28;
            _logoView.frame = CGRectMake(320 - 16 - imgSize.width, 15, imgSize.width, imgSize.height);
        }
    }];
    _nameLabel.text = uD[@"name"];

    UIImage *avatarPlaceholder = nil;
    _avatarView.layer.cornerRadius = 20.0;
    if ([(NSString *)uD[@"profile"][@"gender"] isEqualToString:@"f"])
        avatarPlaceholder = [UIImage imageNamed:@"AvatarPlaceHolderFemaleMedium"];
    else
        avatarPlaceholder = [UIImage imageNamed:@"AvatarPlaceHolderMaleMedium"];
    
    _avatarView.image = avatarPlaceholder;
    if (uD[@"profile"][@"picture"][@"original"])
    {
        NSURL *avatarURL = [[NPCooleafClient sharedClient].baseURL URLByAppendingPathComponent:uD[@"profile"][@"picture"][@"versions"][@"medium"]];
        [[NPCooleafClient sharedClient] fetchImage:avatarURL.absoluteString completion:^(NSString *imagePath, UIImage *image) {
            if (image && [imagePath isEqual:avatarURL.absoluteString])
            {
                _avatarView.image = image;
            }
        }];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
