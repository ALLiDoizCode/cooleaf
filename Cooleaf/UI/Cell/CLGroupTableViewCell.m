//
//  CLGroupTableViewCell.m
//  Cooleaf
//
//  Created by Haider Khan on 9/3/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "CLGroupTableViewCell.h"
#import "CLGroupCollectionViewCell.h"

@implementation CLGroupTableViewCell

- (void)setGroupCollectionView:(UICollectionView *)groupCollectionView {
    if (groupCollectionView != nil) {
        groupCollectionView.delegate = self;
        groupCollectionView.dataSource = self;
        [groupCollectionView reloadData];
    }
    _groupCollectionView = groupCollectionView;
    _groupCollectionView.backgroundColor = [UIColor clearColor];
}

- (void)setUser:(CLUser *)user {
    _user = user;
    [_groupCollectionView reloadData];
}

# pragma mark - Collection View DataSource Methods

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [[_user interests] count];
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CLGroupCollectionViewCell *groupCollectionViewCell = [_groupCollectionView dequeueReusableCellWithReuseIdentifier:@"groupCollectionViewCell" forIndexPath:indexPath];
    groupCollectionViewCell.backgroundColor = [UIColor whiteColor];
    return groupCollectionViewCell;
}

# pragma mark - Collection View 

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = [CLGroupTableViewCell getWidth];
    return CGSizeMake(width, width);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    // Between each row - vertical spacing
    return 10;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    // Horizontal spacing between each item in a row
    return 10;
}

# pragma mark - Helper Methods

+ (CGFloat)getWidth {
    // Total white spacing that is not a cell in a row
    // Example - 10 pt padding left, (20 pt in between) X # of cells, 10 pt right
    CGFloat padding = 40; // TODO - Convert to constants
    int numOfCellsPerRow = 3;
    CGFloat width = [UIScreen mainScreen].bounds.size.width - padding;
    width = width / numOfCellsPerRow;
    return width;
}

+ (CGFloat)getHeightForUser:(CLUser *)user {
    // Get number of interests
    int count = (int)[[user interests] count];
    // Get number of rows, round up
    int noOfRows = ceil(count / 3.0);
    // Get top padding and bottom padding
    CGFloat padding = 10 * (noOfRows + 1);
    // Amount of rows plus padding,
    return (noOfRows * [self getWidth] + padding);
}

@end
