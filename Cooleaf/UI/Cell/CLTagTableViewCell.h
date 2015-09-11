//
//  CLTagTableViewCell.h
//  Cooleaf
//
//  Created by Haider Khan on 9/9/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLUser.h"

@interface CLTagTableViewCell : UITableViewCell <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, assign) CLUser *user;
@property (weak, nonatomic) IBOutlet UICollectionView *tagCollectionView;

@end
