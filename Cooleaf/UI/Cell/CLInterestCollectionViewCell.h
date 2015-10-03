//
//  CLInterestCollectionViewCell.h
//  Cooleaf
//
//  Created by Haider Khan on 10/1/15.
//  Copyright © 2015 Nova Project. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLInterest.h"

@interface CLInterestCollectionViewCell : UICollectionViewCell

@property (readwrite, assign, nonatomic) BOOL editModeOn;
@property (readwrite, strong, nonatomic) CLInterest *interest;
@property (nonatomic) UIImageView *imageView;
@property (nonatomic) UILabel *titleLbl;
@property (nonatomic) UIImageView *checkboxImg;

- (void)toggleCheckBox:(BOOL)isMember;

@end
