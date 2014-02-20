//
//  NPProfileViewController.m
//  Cooleaf
//
//  Created by Bazyli Zygan on 28.12.2013.
//  Copyright (c) 2013 Nova Project. All rights reserved.
//

#import "NPProfileViewController.h"
#import "NPCooleafClient.h"
#import "NPLoginViewController.h"

@interface NPProfileViewController ()

@property (weak, nonatomic) IBOutlet UILabel *rewardPoints;
@property (weak, nonatomic) IBOutlet UIImageView *avatarView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *positionLabel;
@property (weak, nonatomic) IBOutlet UILabel *tagsLabel;
@property (strong, nonatomic) UIImageView *companyView;

- (void)logoutTapped:(id)sender;

@end

@implementation NPProfileViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"";
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Sign out", @"Sign out button title")
                                                                                  style:UIBarButtonItemStyleDone target:self action:@selector(logoutTapped:)];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _avatarView.layer.cornerRadius = 59.0;
    UIImage *avatarPlaceholder = nil;
    NSDictionary *uD = [NPCooleafClient sharedClient].userData;
    if ([(NSString *)uD[@"profile"][@"gender"] isEqualToString:@"f"])
        avatarPlaceholder = [UIImage imageNamed:@"AvatarPlaceHolderFemaleBig"];
    else
        avatarPlaceholder = [UIImage imageNamed:@"AvatarPlaceHolderMaleBig"];
    
    _avatarView.image = avatarPlaceholder;
    if (uD[@"profile"][@"picture"][@"original"])
    {
        NSURL *avatarURL = [[NPCooleafClient sharedClient].baseURL URLByAppendingPathComponent:uD[@"profile"][@"picture"][@"versions"][@"big"]];
        [[NPCooleafClient sharedClient] fetchImage:avatarURL.absoluteString completion:^(NSString *imagePath, UIImage *image) {
            if (image && [imagePath isEqual:avatarURL.absoluteString])
            {
                _avatarView.image = image;
            }
        }];
    }
    
    _nameLabel.text = uD[@"name"];
    if ([uD[@"role"][@"department"][@"default"] boolValue])
        _positionLabel.text = [NSString stringWithFormat:@"%@\n\u00A0", uD[@"role"][@"organization"][@"name"]];
    else
        _positionLabel.text = [NSString stringWithFormat:@"%@\n%@", uD[@"role"][@"department"][@"name"], uD[@"role"][@"organization"][@"name"]];
    _rewardPoints.text = [NSString stringWithFormat:NSLocalizedString(@"%@ reward points", nil), uD[@"reward_points"]];
    
    int c = 3;
    NSMutableString *cats = [NSMutableString new];
    for (NSDictionary *cat in uD[@"categories"])
    {
        c--;
        [cats appendFormat:@"#%@", [cat[@"name"] uppercaseString]];
        if (c > 0)
            [cats appendString:@"\n"];
        
        if (c <= 0)
            break;
    }
    _tagsLabel.text = cats;
    NSURL *companyBannerURL = [[NPCooleafClient sharedClient].baseURL URLByAppendingPathComponent:uD[@"role"][@"organization"][@"logo"][@"versions"][@"thumb"]];
    [[NPCooleafClient sharedClient] fetchImage:companyBannerURL.absoluteString completion:^(NSString *imagePath, UIImage *image) {
       if (image && [imagePath isEqualToString:companyBannerURL.absoluteString])
       {
           _companyView = [[UIImageView alloc] initWithImage:image];
           _companyView.frame = CGRectMake(0, 385 /*[UIScreen mainScreen].bounds.size.height - (image.size.height/2.0) - 30.0 */, 320, (image.size.height/2.0));
           _companyView.contentMode = UIViewContentModeScaleAspectFit;
           _companyView.backgroundColor = [UIColor clearColor];
           [self.view addSubview:_companyView];
       }
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)logoutTapped:(id)sender
{
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:nil
                                                 message:NSLocalizedString(@"Do you really want to sign out of\u00A0Cooleaf?", nil)
                                                delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", nil)
                                       otherButtonTitles:NSLocalizedString(@"Sign out", nil), nil];
    
    [av show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        [[NPCooleafClient sharedClient] logout];
        [self.view.window.rootViewController presentViewController:[NPLoginViewController new] animated:YES completion:^{
            [self.navigationController popToRootViewControllerAnimated:NO];
        }];
        
    }
}
@end
