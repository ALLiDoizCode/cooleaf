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
    UIImage *avatarPlaceholder = nil;
    NSDictionary *uD = [NPCooleafClient sharedClient].userData;
    if ([(NSString *)uD[@"profile"][@"gender"] isEqualToString:@"f"])
        avatarPlaceholder = [UIImage imageNamed:@"AvatarPlaceHolderFemaleBig"];
    else
        avatarPlaceholder = [UIImage imageNamed:@"AvatarPlaceHolderMaleBig"];
    
    _avatarView.image = avatarPlaceholder;
    NSURL *avatarURL = [[NPCooleafClient sharedClient].baseURL URLByAppendingPathComponent:uD[@"profile"][@"picture"][@"big"]];
    [[NPCooleafClient sharedClient] fetchImage:avatarURL.absoluteString completion:^(NSString *imagePath, UIImage *image) {
        if (image && [imagePath isEqual:avatarURL.absoluteString])
        {
            _avatarView.image = image;
        }
    }];
    
    _nameLabel.text = uD[@"name"];
    _positionLabel.text = [NSString stringWithFormat:@"%@\n%@", uD[@"role"][@"department"][@"name"], uD[@"role"][@"organization"][@"name"]];
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
