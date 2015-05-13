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
#import "NPEventListViewController.h"
#import "NPTag.h"
#import "NPTagGroup.h"
#import "NPEditTagsViewController.h"
#import <SSKeychain/SSKeychain.h>


@interface NPProfileViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
	BOOL _editModeOn;
	UIImagePickerController *_avatarController;
	NPInterestsViewController2 *_interestsController;
	
	UILabel *_tagSet1Label1;
	UILabel *_tagSet1Label2;
	UILabel *_tagSet1Label3;
	UILabel *_tagSet2Label1;
	UILabel *_tagSet2Label2;
	UILabel *_tagSet2Label3;
	
	UIView *_tagView3;
}

@property (strong, nonatomic) UIImageView *companyView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIImageView *avatarView;
@property (weak, nonatomic) IBOutlet UIImageView *blurImage;
@property (weak, nonatomic) IBOutlet UIImageView *editDepartment;
@property (weak, nonatomic) IBOutlet UIImageView *editLocation;
@property (weak, nonatomic) IBOutlet UILabel *rewardPoints;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *positionLabel;
//@property (weak, nonatomic) IBOutlet UILabel *tagsLabel;
@property (weak, nonatomic) IBOutlet UIView *clearView;
@property (weak, nonatomic) IBOutlet UIView *imageCoverView;
@property (weak, nonatomic) IBOutlet UIView *tagView1;
@property (weak, nonatomic) IBOutlet UIView *tagView2;
@property (weak, nonatomic) IBOutlet UIView *myGroupsView;
@property (weak, nonatomic) IBOutlet UILabel *tagLabel1;
@property (weak, nonatomic) IBOutlet UILabel *tagLabel2;

- (IBAction)pastEventsButton:(UIButton *)sender;

- (void)logoutTapped:(id)sender;
- (void)editTagsTapped:(id)sender;

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
//	_tagsLabel.hidden = YES;
    _avatarView.layer.cornerRadius = 59.0;
    UIImage *avatarPlaceholder = nil;
    NSDictionary *uD = [NPCooleafClient sharedClient].userData;
	DLog(@"%@",uD);
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
	if ([uD[@"reward_points"] intValue] == 0)
	{_rewardPoints.hidden = TRUE;}

	[_editDepartment addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(editTagsTapped:)]];
	[_editLocation addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(editTagsTapped:)]];
	
	
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
	[self.view addConstraint:[NSLayoutConstraint constraintWithItem:_interestsController.collectionView attribute:NSLayoutAttributeTop    relatedBy:NSLayoutRelationEqual toItem:_imageCoverView attribute:NSLayoutAttributeBottom  multiplier:1 constant:0]];
	[self.view addConstraint:[NSLayoutConstraint constraintWithItem:_interestsController.collectionView attribute:NSLayoutAttributeLeft   relatedBy:NSLayoutRelationEqual toItem:self.view       attribute:NSLayoutAttributeLeft    multiplier:1 constant:0]];
	[self.view addConstraint:[NSLayoutConstraint constraintWithItem:_interestsController.collectionView attribute:NSLayoutAttributeRight  relatedBy:NSLayoutRelationEqual toItem:self.view       attribute:NSLayoutAttributeRight   multiplier:1 constant:0]];
	[self.view addConstraint:[NSLayoutConstraint constraintWithItem:_interestsController.collectionView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.scrollView attribute:NSLayoutAttributeBottom  multiplier:1 constant:0]];
	[self.view layoutIfNeeded];
	self.scrollView.contentSize = CGSizeMake(320, 1000);
//	DLog(@"collectionView = %@", _interestsController.collectionView);
}

- (void)viewWillAppear:(BOOL)animated
{
	[self.navigationController setNavigationBarHidden:FALSE];

//	_tagsLabel.hidden = YES;
	_avatarView.layer.cornerRadius = 59.0;
	UIImage *avatarPlaceholder = nil;
	NSDictionary *uD = [NPCooleafClient sharedClient].userData;
//	NSLog(@"%@",uD);
//	NSLog(@"%@", [[NSString alloc] initWithUTF8String:[NSJSONSerialization dataWithJSONObject:uD options:0 error:nil].bytes]);
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
	if ([uD[@"reward_points"] intValue] == 0)
	{_rewardPoints.hidden = TRUE;}
	DLog(@" The users data is == %@",uD);
	
	
	
	
	//Tag Groups Setup
	NSMutableDictionary *tagGroups = [[NSMutableDictionary alloc] init];

	[(NSArray *)uD[@"role"][@"organization"][@"structures"] enumerateObjectsUsingBlock:^ (NSDictionary *structure, NSUInteger index, BOOL *stop) {
		NPTagGroup *tagGroup = [[NPTagGroup alloc] initWithDictionary:structure];
		tagGroups[tagGroup.name] = tagGroup;
	}];
	DLog(@"The tagGroups are == %@", tagGroups);
	
	
	NSArray *allStructureNames = [tagGroups allKeys];
	DLog(@" All the Structure names are %@", allStructureNames);
	_tagLabel1.text = allStructureNames[0];
	_tagLabel2.text = allStructureNames[1];
	
	NPTagGroup *the1stTagGroup = tagGroups[allStructureNames[0]];
	NPTagGroup *the2ndTagGroup = tagGroups[allStructureNames[1]];
	NPTagGroup *the3rdTagGroup = tagGroups[allStructureNames[2]];

	//Structure Tag Setup
	
	NSMutableArray *npStructureTags = [[NSMutableArray alloc] init];
	[uD[@"role"][@"structure_tags"] enumerateObjectsUsingBlock:^(NSDictionary *structureTag, NSUInteger idx, BOOL *stop) {
		[npStructureTags addObject:[[NPTag alloc] initWithDictionary:structureTag]];
	}];
	DLog(@" Structure Tags are this: %@", npStructureTags);
	
	
	
	
	NSArray *the1stTagsArray = [npStructureTags filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(NPTag *the1stGroupTag, NSDictionary *bindings) {
		return the1stGroupTag.parentId == the1stTagGroup.objectId;
	}]];
	
	DLog(@" the1stTagsArray Tags are this: %@", the1stTagsArray);
	
	NSArray *the2ndTagsArray = [npStructureTags filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(NPTag *the2ndGroupTag, NSDictionary *bindings) {
		return the2ndGroupTag.parentId == the2ndTagGroup.objectId;
	}]];
	
	DLog(@" the2ndTagsArray Tags are this: %@", the2ndTagsArray);

	NSArray *the3rdTagsArray = [npStructureTags filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(NPTag *the3rdGroupTag, NSDictionary *bindings) {
		return the3rdGroupTag.parentId == the3rdTagGroup.objectId;
	}]];
	
	DLog(@" the3rdTagsArray Tags are this: %@", the3rdTagsArray);

	
	
	
	NSMutableArray *the1stStringArray = [[NSMutableArray alloc] init];
	
	[the1stTagsArray enumerateObjectsUsingBlock:^(NPTag *the1stTagString, NSUInteger index, BOOL *stop) {
		[the1stStringArray addObject:the1stTagString.name];
	}];
	DLog(@" the1stStringArray is: %@", the1stStringArray);
	
	NSMutableArray *the2ndStringArray = [[NSMutableArray alloc] init];
	
	[the2ndTagsArray enumerateObjectsUsingBlock:^(NPTag *the2ndTagString, NSUInteger index, BOOL *stop) {
		[the2ndStringArray addObject:the2ndTagString.name];
	}];
	DLog(@" the2ndStringArray is: %@", the2ndStringArray);
	
	NSMutableArray *the3rdStringArray = [[NSMutableArray alloc] init];
	
	[the3rdTagsArray enumerateObjectsUsingBlock:^(NPTag *the3rdTagString, NSUInteger index, BOOL *stop) {
		[the3rdStringArray addObject:the3rdTagString.name];
	}];
	DLog(@" the3rdStringArray is: %@", the3rdStringArray);

	
	
	
	//Structure Tag Layout

	if (the1stStringArray.count > 0) {
		
		_tagSet1Label1 = [[UILabel alloc] init];
		_tagSet1Label1.translatesAutoresizingMaskIntoConstraints = FALSE;
		_tagSet1Label1.font = [UIFont systemFontOfSize:14];
		_tagSet1Label1.textColor = RGB(255.0, 255.0, 255.0);
		_tagSet1Label1.backgroundColor = RGB(78.0, 205.0, 196.0);
		_tagSet1Label1.text = [NSString stringWithFormat:@" %@ ", the1stStringArray[0]];
		[_tagView1 addSubview:_tagSet1Label1];
		[_tagView1 addConstraint:[NSLayoutConstraint constraintWithItem:_tagSet1Label1 attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_tagView1 attribute:NSLayoutAttributeCenterY multiplier:1 constant:0.0]];
		[_tagView1 addConstraint:[NSLayoutConstraint constraintWithItem:_tagSet1Label1 attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_tagView1 attribute:NSLayoutAttributeLeft multiplier:1 constant:15.0]];
	}
	
	if (the1stStringArray.count > 1) {
		_tagSet1Label2 = [[UILabel alloc] init];
		_tagSet1Label2.translatesAutoresizingMaskIntoConstraints = FALSE;
		_tagSet1Label2.font = [UIFont systemFontOfSize:14];
		_tagSet1Label2.textColor = RGB(255.0, 255.0, 255.0);
		_tagSet1Label2.backgroundColor = RGB(78.0, 205.0, 196.0);
		_tagSet1Label2.text = [NSString stringWithFormat:@" %@ ", the1stStringArray[1]];
		[_tagView1 addSubview:_tagSet1Label2];
		[_tagView1 addConstraint:[NSLayoutConstraint constraintWithItem:_tagSet1Label2 attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_tagView1 attribute:NSLayoutAttributeCenterY multiplier:1 constant:0.0]];
		[_tagView1 addConstraint:[NSLayoutConstraint constraintWithItem:_tagSet1Label2 attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_tagSet1Label1 attribute:NSLayoutAttributeRight multiplier:1 constant:10.0]];
	}
	
	if (the1stStringArray.count > 2) {
		
		_tagSet1Label3 = [[UILabel alloc] init];
		_tagSet1Label3.translatesAutoresizingMaskIntoConstraints = FALSE;
		_tagSet1Label3.font = [UIFont systemFontOfSize:14];
		_tagSet1Label3.textColor = RGB(255.0, 255.0, 255.0);
		_tagSet1Label3.backgroundColor = RGB(78.0, 205.0, 196.0);
		_tagSet1Label3.text = [NSString stringWithFormat:@" %@ ", the1stStringArray[2]];
		[_tagView1 addSubview:_tagSet1Label3];
		[_tagView1 addConstraint:[NSLayoutConstraint constraintWithItem:_tagSet1Label3 attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_tagView1 attribute:NSLayoutAttributeCenterY multiplier:1 constant:0.0]];
		[_tagView1 addConstraint:[NSLayoutConstraint constraintWithItem:_tagSet1Label3 attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_tagSet1Label2 attribute:NSLayoutAttributeRight multiplier:1 constant:10.0]];
	}
	
	
	if (the2ndStringArray.count > 0) {
		
		_tagSet2Label1 = [[UILabel alloc] init];
		_tagSet2Label1.translatesAutoresizingMaskIntoConstraints = FALSE;
		_tagSet2Label1.font = [UIFont systemFontOfSize:14];
		_tagSet2Label1.textColor = RGB(255.0, 255.0, 255.0);
		_tagSet2Label1.backgroundColor = RGB(78.0, 205.0, 196.0);
		_tagSet2Label1.text = [NSString stringWithFormat:@" %@ ", the2ndStringArray[0]];
		[_tagView2 addSubview:_tagSet2Label1];
		[_tagView2 addConstraint:[NSLayoutConstraint constraintWithItem:_tagSet2Label1 attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_tagView2 attribute:NSLayoutAttributeCenterY multiplier:1 constant:0.0]];
		[_tagView2 addConstraint:[NSLayoutConstraint constraintWithItem:_tagSet2Label1 attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_tagView2 attribute:NSLayoutAttributeLeft multiplier:1 constant:15.0]];
	}
	
	if (the2ndStringArray.count > 1) {
		
		_tagSet2Label2 = [[UILabel alloc] init];
		_tagSet2Label2.translatesAutoresizingMaskIntoConstraints = FALSE;
		_tagSet2Label2.font = [UIFont systemFontOfSize:14];
		_tagSet2Label2.textColor = RGB(255.0, 255.0, 255.0);
		_tagSet2Label2.backgroundColor = RGB(78.0, 205.0, 196.0);
		_tagSet2Label2.text = [NSString stringWithFormat:@" %@ ", the2ndStringArray[1]];
		[_tagView2 addSubview:_tagSet2Label2];
		[_tagView2 addConstraint:[NSLayoutConstraint constraintWithItem:_tagSet2Label2 attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_tagView2 attribute:NSLayoutAttributeCenterY multiplier:1 constant:0.0]];
		[_tagView2 addConstraint:[NSLayoutConstraint constraintWithItem:_tagSet2Label2 attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_tagSet2Label1 attribute:NSLayoutAttributeRight multiplier:1 constant:10.0]];
	}
	
	if (the2ndStringArray.count > 2) {
		
		_tagSet2Label3 = [[UILabel alloc] init];
		_tagSet2Label3.translatesAutoresizingMaskIntoConstraints = FALSE;
		_tagSet2Label3.font = [UIFont systemFontOfSize:14];
		_tagSet2Label3.textColor = RGB(255.0, 255.0, 255.0);
		_tagSet2Label3.backgroundColor = RGB(78.0, 205.0, 196.0);
		_tagSet2Label3.text = [NSString stringWithFormat:@" %@ ", the2ndStringArray[2]];
		[_tagView2 addSubview:_tagSet2Label3];
		[_tagView2 addConstraint:[NSLayoutConstraint constraintWithItem:_tagSet2Label3 attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_tagView2 attribute:NSLayoutAttributeCenterY multiplier:1 constant:0.0]];
		[_tagView2 addConstraint:[NSLayoutConstraint constraintWithItem:_tagSet2Label3 attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_tagSet2Label2 attribute:NSLayoutAttributeRight multiplier:1 constant:10.0]];
	}
	

	
//	if (allStructureNames.count > 2) {
//		_tagView3 = [[UIView alloc] init];
//		_tagView3.translatesAutoresizingMaskIntoConstraints = FALSE;
//		_tagView3.backgroundColor = UIColor.whiteColor;
//		[_imageCoverView addSubview:_tagView3];
//		[_imageCoverView addConstraint:[NSLayoutConstraint constraintWithItem:_tagView3 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:_tagView2 attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
//		[_imageCoverView addConstraint:[NSLayoutConstraint constraintWithItem:_tagView3 attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:_tagView2 attribute:NSLayoutAttributeHeight multiplier:1 constant:0]];
//		[_imageCoverView addConstraint:[NSLayoutConstraint constraintWithItem:_tagView3 attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:_tagView2 attribute:NSLayoutAttributeWidth multiplier:1 constant:0]];
//	}
//	
//	
//	
	
	
	
	
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
	self.navigationItem.leftBarButtonItem.title = _editModeOn ? @"Done" : @"Edit";
	_interestsController.editModeOn = _editModeOn;
}

- (IBAction)pastEventsButton:(UIButton *)sender
{
	NPEventListViewController *pastEventListController = [NPEventListViewController new];
	pastEventListController.title = @"Past Events";
	pastEventListController.loadEventType = @"pastEvents";
	
	DLog(@"selected the Past Events");
	[self.navigationController pushViewController:pastEventListController animated:YES];

}

- (void)editTagsTapped:(id)sender
{
	DLog(@"Tags Tags Everywhere");
	NPEditTagsViewController *editTagsViewController = [NPEditTagsViewController new];
	[self.navigationController pushViewController:editTagsViewController animated:YES];
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
			[self.view.window.rootViewController presentViewController:[[UINavigationController alloc] initWithRootViewController:[NPLoginViewController new]] animated:NO completion:^{
				[self.navigationController popToRootViewControllerAnimated:NO];
			}];
//        [self.view.window.rootViewController presentViewController:[NPLoginViewController new] animated:YES completion:^{
//            [self.navigationController popToRootViewControllerAnimated:NO];
//        }];
			
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
			[[NPCooleafClient sharedClient] updateProfileDataAllFields:nil email:nil password:nil tags:nil removed_picture:FALSE file_cache:unused[@"file_cache"] role_structure_required:uD[@"role"] profileDailyDigest:nil profileWeeklyDigest:nil profile:uD[@"profile"] completion:^{
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
