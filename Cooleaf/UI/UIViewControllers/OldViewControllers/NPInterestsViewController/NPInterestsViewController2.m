//
//  NPInterestsViewController.m
//  Cooleaf
//
//  Created by Curtis Jones on 2015.03.12.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import <SDWebImage/UIImageView+WebCache.h>
#import "NPInterestsViewController2.h"
#import "NPInterestsHeaderViewCell.h"
#import "NPPickYourInterestsLabelCell.h"
#import "NPCooleafClient.h"
#import "NPInterest.h"
#import "CLInterestPresenter.h"
#import "CLInterest.h"
#import "CLFilePreviewsPresenter.h"
#import "CLFilePreview.h"
#import "CLUserPresenter.h"
#import "TWMessageBarManager.h"

#define CellHeight 145 + 30 + 10 + 2

static NSString * const reuseIdentifier = @"Cell";

@interface NPInterestsViewController2() {
    CLInterestPresenter *_interestPresenter;
    CLFilePreviewsPresenter *_filePreviewPresenter;
    CLUserPresenter *_userPresenter;
	NSMutableArray *_interests;
    NSMutableArray *_activeInterestIds;
	NSLayoutConstraint *_heightConstraint;
    CLFilePreview *_filePreview;
}
@end

@implementation NPInterestsViewController2

#pragma mark - UICollectionViewController

- (id)init {
	UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
	layout.minimumInteritemSpacing = 0;
	layout.minimumLineSpacing = 12.;
	[layout setScrollDirection:UICollectionViewScrollDirectionVertical];
	
	self = [super initWithCollectionViewLayout:layout];
	
	if (self) {
		
	}
	
	return self;
}

# pragma mark - LifeCycle Methods

- (void)viewDidLoad {
	[super viewDidLoad];
    [self setupCollectionView];
}

- (void)viewWillAppear:(BOOL)animated {
	[self.navigationController setNavigationBarHidden:FALSE];
    [self setupInterestPresenter];
    [self setupFilePreviewPresenter];
    [self setupUserPresenter];
	[self reload];
    _activeInterestIds = [NSMutableArray new];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_interestPresenter unregisterOnBus];
    [_filePreviewPresenter unregisterOnBus];
    [_userPresenter unregisterOnBus];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
}

# pragma mark - setupCollectionView

- (void)setupCollectionView {
    self.collectionView.backgroundColor = UIColor.whiteColor;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self.collectionView registerClass:[NPInterestViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    [self.collectionView registerClass:[NPInterestsHeaderViewCell class] forCellWithReuseIdentifier:@"HeaderCell"];
    [self.collectionView registerClass:[NPPickYourInterestsLabelCell class] forCellWithReuseIdentifier:@"NPPickYourInterestsLabelCell"];
    
    _heightConstraint = [NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:0];
    [self.collectionView addConstraint:_heightConstraint];
    // TODO - Add 20 pts to top, but won't work well in landscape mode
    self.collectionView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
}

# pragma mark - setupInterestPresenter

- (void)setupInterestPresenter {
    _interestPresenter = [[CLInterestPresenter alloc] initWithInteractor:self];
    [_interestPresenter registerOnBus];
}

# pragma mark - setupFilePreviewPresenter

- (void)setupFilePreviewPresenter {
    _filePreviewPresenter = [[CLFilePreviewsPresenter alloc] initWithInteractor:self];
    [_filePreviewPresenter registerOnBus];
}

- (void)setupUserPresenter {
    _userPresenter = [[CLUserPresenter alloc] initWithInteractor:self];
    [_userPresenter registerOnBus];
}

# pragma mark - IInterestInteractor Methods

- (void)initInterests:(NSMutableArray *)interests {
    _interests = interests;
    for (CLInterest *interest in _interests) {
        NSInteger interestId = [[interest interestId] integerValue];
        BOOL isMember = interest.member;
        if (isMember) {
            if (![_activeInterestIds containsObject:@(interestId)])
                [_activeInterestIds addObject:@(interestId)];
        }
    }
    [self.collectionView reloadData];
}

# pragma mark - IFilePreviewInteractor Methods

- (void)initWithFilePreview:(CLFilePreview *)filePreview {
    NSString *fileCache = [filePreview fileCache];
    [_userPresenter saveUserInterests:_user activeInterests:_activeInterestIds fileCache:fileCache];
}

# pragma mark - IUserInteractor Methods

- (void)initSavedUser:(CLUser *)savedUser {
    if (self.presentingViewController.presentingViewController)
        [self.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    else
        [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

# pragma mark - NPInterestViewCellDelegate 

- (void)toggleCheckBox:(NPInterestViewCell *)interestViewCell {
    // Set the active interests in the array if the interestViewCell has an interest
    if (interestViewCell.interest) {
        NSInteger interestId = [interestViewCell.interest.interestId integerValue];
        BOOL isMember = interestViewCell.interest.member;
        if (isMember) {
            if (![_activeInterestIds containsObject:@(interestId)])
                [_activeInterestIds addObject:@(interestId)];
        } else {
            if ([_activeInterestIds containsObject:@(interestId)])
                [_activeInterestIds removeObject:@(interestId)];
        }
    }
}

# pragma mark - Accessors

- (void)reload {
    
    if (_scrollEnabled == TRUE) {
        self.collectionView.scrollEnabled = TRUE;
        _heightConstraint.constant = self.view.window.frame.size.height;
    }
    else {
        self.collectionView.scrollEnabled = FALSE;
    }
    
    [self.collectionView reloadData];
    
    // If TRUE, user is editing interests during registration, else user is editing profile
    if (_editModeOn == TRUE) {
        [_interestPresenter loadInterests];
    } else {
		//[[NPCooleafClient sharedClient] getUserInterests:handler];
    }
}

/**
 * Sets the edit more for the interests. If we're enabling edit mode, we'll reload the view with
 * the complete set of interests. If we're disabling edit mode, then we need to take the current
 * interests, filter it to the enabled set, and update the user's profile; and then reload.
 */
- (void)setEditModeOn:(BOOL)editModeOn {
	_editModeOn = editModeOn;
	
	if (_editModeOn == TRUE) {
		[self reload];
	}
	else {
		NSArray *activeInterests = [_interests filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^ BOOL (NPInterest *npinterest, NSDictionary *bindings) { return npinterest.isMember; }]];
		//[[NPCooleafClient sharedClient] setUserInterests:activeInterests completion:^ (BOOL success) { [self reload]; }];
	}
}

- (void)setTopBarEnabled:(BOOL)topBarEnabled {
	_topBarEnabled = topBarEnabled;
	[self.collectionView reloadData];
}

#pragma mark - Actions

- (void)doToggleInterest:(id)sender {
    NSLog(@"doToggleInterest");
}

- (void)doActionBack:(id)sender {
	[self dismissViewControllerAnimated:YES completion:nil];
}

- (void)doActionNext:(id)sender {
    [[TWMessageBarManager sharedInstance] showMessageWithTitle:@"Updating..." description:@"We're updating your profile." type:TWMessageBarMessageTypeInfo];
    if (_userAvatar)
        [_filePreviewPresenter uploadProfilePhoto:_userAvatar];
    else
        [_userPresenter saveUserInterests:_user activeInterests:_activeInterestIds fileCache:nil];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
	return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	if (_topBarEnabled && section == 0)
		return 1;
	else if (_topBarEnabled && section == 1)
		return 1;
	else
		return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	if (_topBarEnabled && indexPath.section == 0) {
		NPInterestsHeaderViewCell *cell = (NPInterestsHeaderViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"HeaderCell" forIndexPath:indexPath];
		cell.backHandler = ^ { [self doActionBack:nil]; };
		cell.nextHandler = ^ { [self doActionNext:nil]; };
		return cell;
	}
	if (_topBarEnabled && indexPath.section == 1) {
		NPPickYourInterestsLabelCell *cell = (NPPickYourInterestsLabelCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"NPPickYourInterestsLabelCell" forIndexPath:indexPath];
		return cell;
	}
	else {
		NPInterestViewCell *cell = (NPInterestViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
		cell.editModeOn = _editModeOn;
        
        // Set the delegate
        cell.delegate = self;
        
        // Get the interest
        CLInterest *interest = [_interests objectAtIndex:[indexPath row]];
        
        // Set the interest in the cell
        [cell setInterest:interest];
        
        // Get name and image
        NSString *name = [interest name];
        CLImage *image = [interest image];
        
        // Get image path
        if ([image url]) {
            NSString *url = [image url];
            NSString *fullPath = [NSString stringWithFormat:@"%@%@", @"http:", url];
            fullPath = [fullPath stringByReplacingOccurrencesOfString:@"{{SIZE}}" withString:@"164x164"];
            
            // Set image
            [cell.imageView sd_setImageWithURL:[NSURL URLWithString:fullPath]
                                   placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
            
            cell.imageView.contentMode = UIViewContentModeScaleAspectFill;
            [cell.imageView setClipsToBounds:YES];
        }
        
        // Set checkbox
        [cell toggleCheckbox:[interest member]];
        
        // Set name
        cell.titleLbl.text = [NSString stringWithFormat:@"%@%@", @"#", name];

		return cell;
	}
}

#pragma mark - UICollectionViewDelegate

//- (UICollectionReusableView *)collectionView: (UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
//	self.trackHeader = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"TrackHeader" forIndexPath:indexPath];
//	self.trackHeader.trackTxt.attributedText = mTrackTxt;
//	return self.trackHeader;
//}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    // User clicked on fxblurview toggle cell
    if ([indexPath section] == 3) {
        NPInterestViewCell *interestCell = (NPInterestViewCell *) [self.collectionView cellForItemAtIndexPath:indexPath];
        [self toggleCheckBox:interestCell];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
	// TODO: Deselect item
}

/*
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/


#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
	if (_topBarEnabled && indexPath.section == 0)
		return CGSizeMake(320, 50);
	else if (_topBarEnabled && indexPath.section == 1)
		return CGSizeMake(320, 40);
	else if (_topBarEnabled && indexPath.section == 3)
		return CGSizeMake(320, 50);
	else
		return CGSizeMake(145, 145);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
	if (_topBarEnabled && section == 0)
		return UIEdgeInsetsMake(0, 0, 0, 0);
	else if (_topBarEnabled && section == 1)
		return UIEdgeInsetsMake(0, 0, 0, 0);
	else if (_topBarEnabled && section == 3)
		return UIEdgeInsetsMake(0, 0, 0, 0);
	else
		return UIEdgeInsetsMake(10, 10, 10, 10);
}

@end
