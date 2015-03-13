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

static NSString * const reuseIdentifier = @"Cell";

@interface NPInterestsViewController2 ()
{
	NSArray *_npinterests;
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
	
	self.collectionView.backgroundColor = UIColor.greenColor;
	self.collectionView.delegate = self;
	self.collectionView.dataSource = self;
	
	// Uncomment the following line to preserve selection between presentations
	// self.clearsSelectionOnViewWillAppear = NO;
	
	// Register cell classes
	[self.collectionView registerClass:[NPInterestViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
	
	[[NPCooleafClient sharedClient] fetchInterestList:^ (NSArray *npinterests) {
		DLog(@"interests = %@", npinterests);
	}];
}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
}





#pragma mark - Accessors

- (void)reload
{
	[self.collectionView reloadData];
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
	UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
	
	// Configure the cell
	
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
	return CGSizeMake(145, 140);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
	return UIEdgeInsetsMake(10, 10, 10, 10);
}

@end
