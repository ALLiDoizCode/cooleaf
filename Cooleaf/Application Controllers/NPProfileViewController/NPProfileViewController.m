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
                                                                                  style:UIBarButtonItemStylePlain target:self action:@selector(logoutTapped:)];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _avatarView.layer.cornerRadius = 36.0;
    UIImage *avatarPlaceholder = nil;
    NSDictionary *uD = [NPCooleafClient sharedClient].userData;
    if ([(NSString *)uD[@"profile"][@"gender"] isEqualToString:@"f"])
        avatarPlaceholder = [UIImage imageNamed:@"AvatarPlaceHolderFemaleBig"];
    else
        avatarPlaceholder = [UIImage imageNamed:@"AvatarPlaceHolderMaleBig"];
    
    _avatarView.image = avatarPlaceholder;
    NSURL *avatarURL = [[NPCooleafClient sharedClient].baseURL URLByAppendingPathComponent:uD[@"profile"][@"picture"][@"versions"][@"big"]];
    [[NPCooleafClient sharedClient] fetchImage:avatarURL.absoluteString completion:^(NSString *imagePath, UIImage *image) {
        if (image && [imagePath isEqual:avatarURL.absoluteString])
        {
            _avatarView.image = image;
        }
    }];
    
    _nameLabel.text = uD[@"name"];
    _positionLabel.text = [NSString stringWithFormat:@"%@\n%@", uD[@"role"][@"department"][@"name"], uD[@"role"][@"organization"][@"name"]];
    
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
           _companyView.frame = CGRectMake(0, self.view.bounds.size.height - (image.size.height/2.0), 320, (image.size.height/2.0));
           _companyView.contentMode = UIViewContentModeCenter;
           [self.view addSubview:_companyView];
       }
    }];
    NSLog(@"Got data %@", [NPCooleafClient sharedClient].userData);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)logoutTapped:(id)sender
{
    [[NPCooleafClient sharedClient] logout];
    [self.view.window.rootViewController presentViewController:[NPLoginViewController new] animated:YES completion:^{
        [self.navigationController popToRootViewControllerAnimated:NO];
    }];
}

@end
