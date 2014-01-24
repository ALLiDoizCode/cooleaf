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

@property (weak, nonatomic) IBOutlet UILabel *peopleCountLabel;
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
    _peopleCountLabel.text = [NSString stringWithFormat:NSLocalizedString(@"You and %@ others", nil), uD[@"role"][@"organization"][@"users_count"]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
