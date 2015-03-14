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
#import "NPInterestsViewController2.h"
#import <SSKeychain/SSKeychain.h>


@interface NPProfileViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
	BOOL _editModeOn;
	UIImagePickerController *_avatarController;
	NPInterestsViewController2 *_interestsController;
}

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *rewardPoints;
@property (weak, nonatomic) IBOutlet UIImageView *avatarView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *positionLabel;
@property (weak, nonatomic) IBOutlet UILabel *tagsLabel;
@property (strong, nonatomic) UIImageView *companyView;
@property (weak, nonatomic) IBOutlet UIImageView *blurImage;
@property (weak, nonatomic) IBOutlet UIView *clearView;
@property (weak, nonatomic) IBOutlet UIView *imageCoverView;

- (void)logoutTapped:(id)sender;

@end

@implementation NPProfileViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Profile";
		self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Sign out", @"Sign out button title") style:UIBarButtonItemStyleDone target:self action:@selector(logoutTapped:)];
		self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Edit", @"Edit Profile button title") style:UIBarButtonItemStyleDone target:self action:@selector(editTapped:)];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	_tagsLabel.hidden = YES;
    _avatarView.layer.cornerRadius = 59.0;
    UIImage *avatarPlaceholder = nil;
    NSDictionary *uD = [NPCooleafClient sharedClient].userData;
	NSLog(@"%@",uD);
    if ([(NSString *)uD[@"profile"][@"gender"] isEqualToString:@"f"])
        avatarPlaceholder = [UIImage imageNamed:@"AvatarPlaceHolderFemaleBig"];
    else
        avatarPlaceholder = [UIImage imageNamed:@"AvatarPlaceHolderMaleBig"];
    
    _avatarView.image = avatarPlaceholder;
		_avatarView.userInteractionEnabled = TRUE;
		[_avatarView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doActionPicture:)]];
	
	if (uD[@"profile"][@"picture"][@"versions"][@"large"])
    {
        NSURL *avatarURL = [[NPCooleafClient sharedClient].baseURL URLByAppendingPathComponent:uD[@"profile"][@"picture"][@"versions"][@"big"]];
        [[NPCooleafClient sharedClient] fetchImage:avatarURL.absoluteString completion:^(NSString *imagePath, UIImage *image) {
            if (image && [imagePath isEqual:avatarURL.absoluteString])
            {
                _avatarView.image = image;
				_blurImage.image = image;
				UIToolbar* bgToolbar = [[UIToolbar alloc] initWithFrame:_clearView.frame];
				bgToolbar.barStyle = UIBarStyleBlackOpaque;
				[_clearView.superview insertSubview:bgToolbar belowSubview:_clearView];
            }
        }];
    }
    
    _nameLabel.text = uD[@"name"];
    if ([uD[@"role"][@"department"][@"default"] boolValue])
        _positionLabel.text = [NSString stringWithFormat:@"%@\u00A0", uD[@"role"][@"organization"][@"name"]];
    else
        _positionLabel.text = [NSString stringWithFormat:@"%@, %@", uD[@"role"][@"department"][@"name"], uD[@"role"][@"organization"][@"name"]];
    _rewardPoints.text = [NSString stringWithFormat:NSLocalizedString(@"%@ reward points", nil), uD[@"reward_points"]];

//    int c = 3;
//    NSMutableString *cats = [NSMutableString new];
//    for (NSDictionary *cat in uD[@"categories"])
//    {
//        c--;
//        [cats appendFormat:@"#%@", [cat[@"name"] uppercaseString]];
//        if (c > 0)
//            [cats appendString:@"\n"];
//        
//        if (c <= 0)
//            break;
//    }
//    _tagsLabel.text = cats;
//    NSURL *companyBannerURL = [[NPCooleafClient sharedClient].baseURL URLByAppendingPathComponent:uD[@"role"][@"organization"][@"logo"][@"versions"][@"thumb"]];
//    [[NPCooleafClient sharedClient] fetchImage:companyBannerURL.absoluteString completion:^(NSString *imagePath, UIImage *image) {
//       if (image && [imagePath isEqualToString:companyBannerURL.absoluteString])
//       {
//           _companyView = [[UIImageView alloc] initWithImage:image];
//           _companyView.frame = CGRectMake(0, 385 /*[UIScreen mainScreen].bounds.size.height - (image.size.height/2.0) - 30.0 */, 320, (image.size.height/2.0));
//           _companyView.contentMode = UIViewContentModeScaleAspectFit;
//           _companyView.backgroundColor = [UIColor clearColor];
//           [self.view addSubview:_companyView];
//       }
//
//    }];
	
	_interestsController = [[NPInterestsViewController2 alloc] init];
	_interestsController.collectionView.translatesAutoresizingMaskIntoConstraints = FALSE;
	[self.scrollView addSubview:_interestsController.collectionView];
//[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[topView][view(300)]|" options:0 metrics:nil views:@{@"view": _interestsController.collectionView, @"topView": _imageCoverView}]];
//[self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[view(320)]|" options:0 metrics:nil views:@{@"view": _interestsController.collectionView}]];
	[self.view addConstraint:[NSLayoutConstraint constraintWithItem:_interestsController.collectionView attribute:NSLayoutAttributeTop   relatedBy:NSLayoutRelationEqual toItem:_imageCoverView attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
	[self.view addConstraint:[NSLayoutConstraint constraintWithItem:_interestsController.collectionView attribute:NSLayoutAttributeLeft  relatedBy:NSLayoutRelationEqual toItem:self.view       attribute:NSLayoutAttributeLeft   multiplier:1 constant:0]];
	[self.view addConstraint:[NSLayoutConstraint constraintWithItem:_interestsController.collectionView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view       attribute:NSLayoutAttributeRight  multiplier:1 constant:0]];
	[self.view addConstraint:[NSLayoutConstraint constraintWithItem:_interestsController.collectionView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.scrollView attribute:NSLayoutAttributeBottom  multiplier:1 constant:0]];
	[self.view layoutIfNeeded];
	self.scrollView.contentSize = CGSizeMake(320, 1000);
	DLog(@"collectionView = %@", _interestsController.collectionView);
}

- (void)viewWillAppear:(BOOL)animated
{
	_tagsLabel.hidden = YES;
	_avatarView.layer.cornerRadius = 59.0;
	UIImage *avatarPlaceholder = nil;
	NSDictionary *uD = [NPCooleafClient sharedClient].userData;
	NSLog(@"%@",uD);
	NSLog(@"%@", [[NSString alloc] initWithUTF8String:[NSJSONSerialization dataWithJSONObject:uD options:0 error:nil].bytes]);
	if ([(NSString *)uD[@"profile"][@"gender"] isEqualToString:@"f"])
		avatarPlaceholder = [UIImage imageNamed:@"AvatarPlaceHolderFemaleBig"];
	else
		avatarPlaceholder = [UIImage imageNamed:@"AvatarPlaceHolderMaleBig"];
	
	_avatarView.image = avatarPlaceholder;
	if (uD[@"profile"][@"picture"][@"versions"][@"large"])
	{
		NSURL *avatarURL = [[NPCooleafClient sharedClient].baseURL URLByAppendingPathComponent:uD[@"profile"][@"picture"][@"versions"][@"big"]];
		[[NPCooleafClient sharedClient] fetchImage:avatarURL.absoluteString completion:^(NSString *imagePath, UIImage *image) {
			if (image && [imagePath isEqual:avatarURL.absoluteString])
			{
				_avatarView.image = image;
				_blurImage.image = image;
				UIToolbar* bgToolbar = [[UIToolbar alloc] initWithFrame:_clearView.frame];
				bgToolbar.barStyle = UIBarStyleBlackOpaque;
				[_clearView.superview insertSubview:bgToolbar belowSubview:_clearView];
			}
		}];
	}
	
	_nameLabel.text = uD[@"name"];
	if ([uD[@"role"][@"department"][@"default"] boolValue])
		_positionLabel.text = [NSString stringWithFormat:@"%@\u00A0", uD[@"role"][@"organization"][@"name"]];
	else
		_positionLabel.text = [NSString stringWithFormat:@"%@, %@", uD[@"role"][@"department"][@"name"], uD[@"role"][@"organization"][@"name"]];
	_rewardPoints.text = [NSString stringWithFormat:NSLocalizedString(@"%@ reward points", nil), uD[@"reward_points"]];
	
	[_interestsController viewWillAppear:animated];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (UITabBarItem *)tabBarItem
{
	return [[UITabBarItem alloc] initWithTitle:self.title
										 image:[[UIImage imageNamed:@"ProfileTab"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
								 selectedImage:[UIImage imageNamed:@"ProfileTab"]];
}

- (void)editTapped:(id)sender
{
	_editModeOn = !_editModeOn;
	_interestsController.editModeOn = _editModeOn;
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





#pragma mark - Actions

- (void)doActionPicture:(id)sender
{
	_avatarController = [[UIImagePickerController alloc] init];
	_avatarController.delegate = self;
	_avatarController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
	[self presentViewController:_avatarController animated:TRUE completion:nil];
}

- (void)doActionPictureCamera:(id)sender
{
	UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithTitle:@"Library" style:UIBarButtonItemStylePlain target:self action:@selector(doActionPictureLibrary:)];
	_avatarController.navigationBar.topItem.leftBarButtonItem = button;
	_avatarController.sourceType = UIImagePickerControllerSourceTypeCamera;
}

- (void)doActionPictureLibrary:(id)sender
{
	UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithTitle:@"Camera" style:UIBarButtonItemStylePlain target:self action:@selector(doActionPictureCamera:)];
	_avatarController.navigationBar.topItem.leftBarButtonItem = button;
	_avatarController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
}

//- (void)doActionSaveProfileChanges:(id)sender
//{
//	NSDictionary *uD = [NPCooleafClient sharedClient].userData;
////	NSString *name = uD[@"name"];
////	NSString *email = uD[@"email"];
////	NSString *username = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
////	NSString *password = [SSKeychain passwordForService:@"Cooleaf" account:username];
//	
//	[[NPCooleafClient sharedClient] updateProfileDataAllFields:name email:email password:password tags:<#(NSArray *)#> removed_picture:@"False" file_cache:<#(NSString *)#> role_structure:<#(NSArray *)#> completion:<#^(void)completion#>]
//}
//


#pragma mark - UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
	if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
		UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithTitle:@"Camera" style:UIBarButtonItemStylePlain target:self action:@selector(doActionPictureCamera:)];
		navigationController.navigationBar.topItem.leftBarButtonItem = button;
	}
}





#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
	DLog(@"%@", info);
	
	_avatarView.image = info[UIImagePickerControllerOriginalImage];
	[_avatarController dismissViewControllerAnimated:TRUE completion:nil];
	_avatarController = nil;
	
//UIImage *image = [UIImage imageNamed:@"AttendeeActiveIcon"];
//NSData *imageData = UIImageJPEGRepresentation(image, 1);
//NSData *imageData = UIImagePNGRepresentation(_avatarView.image);
	
//if (imageData != nil ) {
		[[NPCooleafClient sharedClient] updatePictureWithImage:_avatarView.image completion:^ (NSDictionary *unused) {
			DLog(@"Done!");
//		DLog(@"%@", respnoseObject);
//		[self viewWillAppear:FALSE];
			NSURL *avatarURL = [[NPCooleafClient sharedClient].baseURL URLByAppendingPathComponent:unused[@"versions"][@"big"]];
			DLog(@"avatarUrl = %@", avatarURL);
			[[NPCooleafClient sharedClient] fetchImage:avatarURL.absoluteString completion:^(NSString *imagePath, UIImage *image) {
				if (image && [imagePath isEqual:avatarURL.absoluteString])
				{
					_avatarView.image = image;
					_blurImage.image = image;
					UIToolbar* bgToolbar = [[UIToolbar alloc] initWithFrame:_clearView.frame];
					bgToolbar.barStyle = UIBarStyleBlackOpaque;
					[_clearView.superview insertSubview:bgToolbar belowSubview:_clearView];
				}
				
				
			}];
			NSDictionary *uD = [NPCooleafClient sharedClient].userData;
			[[NPCooleafClient sharedClient] updateProfileDataAllFields:nil email:nil password:nil tags:nil removed_picture:FALSE file_cache:unused[@"file_cache"] role_structure_required:uD[@"role"] profileDailyDigest:TRUE profileWeeklyDigest:TRUE profile:uD[@"profile"] completion:^{
				NSLog(@"Success");
			}];
		}];
//}
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
	if (_avatarController.sourceType == UIImagePickerControllerSourceTypeCamera) {
		[self doActionPictureLibrary:picker];
	}
	else {
		[_avatarController dismissViewControllerAnimated:TRUE completion:nil];
		_avatarController = nil;
	}
}

@end
