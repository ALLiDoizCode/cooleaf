//
//  CLInterestsCollectionViewController.m
//  Cooleaf
//
//  Created by Haider Khan on 10/1/15.
//  Copyright © 2015 Nova Project. All rights reserved.
//

#import <SDWebImage/UIImageView+WebCache.h>
#import "CLInterestsCollectionViewController.h"
#import "CLInterestCollectionViewCell.h"
#import "CLInterestPresenter.h"

#define CellHeight 145 + 30 + 10 + 2

static NSString *const reuseIdentifier = @"Cell";

@interface CLInterestsCollectionViewController() {
    @private
    CLInterestPresenter *_interestPresenter;
}

@end

@implementation CLInterestsCollectionViewController

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
    [super viewWillAppear:animated];
    [self setupInterestPresenter];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    
}

# pragma mark - setupCollectionView

- (void)setupCollectionView {
    self.collectionView.backgroundColor = UIColor.whiteColor;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self.collectionView registerClass:[CLInterestCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
}

# pragma mark - setupInterestPresenter

- (void)setupInterestPresenter {
    _interestPresenter = [[CLInterestPresenter alloc] initWithInteractor:self];
    [_interestPresenter registerOnBus];
    [_interestPresenter loadInterests];
}

# pragma mark - IInterestInteractor Methods

- (void)initInterests:(NSMutableArray *)interests {
    _interests = interests;
    [self.collectionView reloadData];
}

#pragma mark - Actions

- (void)doActionBack:(id)sender {
    [self.navigationController popViewControllerAnimated:TRUE];
}

- (void)doActionNext:(id)sender {
//    NSArray *activeInterests = [_npinterests filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^ BOOL (NPInterest *npinterest, NSDictionary *bindings) { return npinterest.isMember; }]];
//    [[NPCooleafClient sharedClient] setUserInterests:activeInterests completion:^ (BOOL success) {
//        [self.navigationController dismissViewControllerAnimated:TRUE completion:nil];
//    }];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_interests count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CLInterestCollectionViewCell *cell = (CLInterestCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.editModeOn = YES;
        
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
        
    // Set name
    cell.titleLbl.text = [NSString stringWithFormat:@"%@%@", @"#", name];
        
    // If active set as checked
    BOOL active = [interest member];
    [cell toggleCheckBox:active];
        
    return cell;
}

# pragma mark - UICollectionViewDelegate

//- (UICollectionReusableView *)collectionView: (UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
//	self.trackHeader = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"TrackHeader" forIndexPath:indexPath];
//	self.trackHeader.trackTxt.attributedText = mTrackTxt;
//	return self.trackHeader;
//}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    // TODO: Select Item
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
    return CGSizeMake(145, 145);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

@end
