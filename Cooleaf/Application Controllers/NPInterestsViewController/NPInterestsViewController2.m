//
//  NPInterestsViewController.m
//  Cooleaf
//
//  Created by Curtis Jones on 2015.03.12.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "NPInterestsViewController2.h"
#import "NPInterestViewCell.h"
#import "NPCooleafClient.h"
#import "NPInterest.h"

#define CellHeight 140 + 38 + 10

static NSString * const reuseIdentifier = @"Cell";

@interface NPInterestsViewController2 ()
{
	NSArray *_npinterests;
	NSLayoutConstraint *_heightConstraint;
}
@end

@implementation NPInterestsViewController2

#pragma mark - UICollectionViewController

- (id)init
{
	UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
	layout.minimumInteritemSpacing = 0;
	layout.minimumLineSpacing = 12.;
//layout.headerReferenceSize = CGSizeMake(SelfViewWidth, 145);
	[layout setScrollDirection:UICollectionViewScrollDirectionVertical];
	
	self = [super initWithCollectionViewLayout:layout];
	
	if (self) {
		
	}
	
	return self;
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	self.collectionView.backgroundColor = UIColor.whiteColor;
	self.collectionView.delegate = self;
	self.collectionView.dataSource = self;
	self.collectionView.scrollEnabled = FALSE;
	
	[self.collectionView registerClass:[NPInterestViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
	
	_heightConstraint = [NSLayoutConstraint constraintWithItem:self.collectionView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:0];
	[self.collectionView addConstraint:_heightConstraint];
}

- (void)viewWillAppear:(BOOL)animated
{
	[self reload];
}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
}





#pragma mark - Accessors

- (void)reload
{
	void (^handler)(NSArray*) = ^ (NSArray *npinterests) {
		DLog(@"interests = %@", npinterests);
		_npinterests = npinterests;
		_heightConstraint.constant = ceilf((float)npinterests.count / 2.0) * CellHeight;
		[self.collectionView reloadData];
	};
	
	if (_editModeOn == TRUE)
		[[NPCooleafClient sharedClient] getAllInterests:handler];
	else
		[[NPCooleafClient sharedClient] getUserInterests:handler];
}

/**
 * Sets the edit more for the interests. If we're enabling edit mode, we'll reload the view with
 * the complete set of interests. If we're disabling edit mode, then we need to take the current
 * interests, filter it to the enabled set, and update the user's profile; and then reload.
 */
- (void)setEditModeOn:(BOOL)editModeOn
{
	_editModeOn = editModeOn;
	
	if (_editModeOn == TRUE)
		[self reload];
	else {
		NSArray *activeInterests = [_npinterests filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^ BOOL (NPInterest *npinterest, NSDictionary *bindings) { return npinterest.isActive; }]];
		[[NPCooleafClient sharedClient] setUserInterests:activeInterests completion:^ (BOOL success) { [self reload]; }];
	}
}





#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
	return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
	return _npinterests.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
	NPInterestViewCell *cell = (NPInterestViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
	
	cell.editModeOn = _editModeOn;
	cell.interest = _npinterests[indexPath.row];
	
	return cell;
}





#pragma mark - UICollectionViewDelegate

//- (UICollectionReusableView *)collectionView: (UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
//	self.trackHeader = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"TrackHeader" forIndexPath:indexPath];
//	self.trackHeader.trackTxt.attributedText = mTrackTxt;
//	return self.trackHeader;
//}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
	// TODO: Select Item
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
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

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
	return CGSizeMake(145, 140 + 38);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
	return UIEdgeInsetsMake(10, 10, 10, 10);
}

@end
