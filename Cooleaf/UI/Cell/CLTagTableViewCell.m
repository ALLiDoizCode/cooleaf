//
//  CLTagTableViewCell.m
//  Cooleaf
//
//  Created by Haider Khan on 9/9/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "CLTagTableViewCell.h"

@implementation CLTagTableViewCell

- (void)setTagCollectionView:(UICollectionView *)tagCollectionView {
    if (tagCollectionView != nil) {
        tagCollectionView.delegate = self;
        tagCollectionView.dataSource = self;
        [tagCollectionView reloadData];
    }
    _tagCollectionView = tagCollectionView;
    _tagCollectionView.backgroundColor = [UIColor clearColor];
}

- (void)setUser:(CLUser *)user {
    
}

@end
