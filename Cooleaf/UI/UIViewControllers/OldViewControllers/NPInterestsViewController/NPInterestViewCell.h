//
//  NPInterestViewCell.h
//  Cooleaf
//
//  Created by Curtis Jones on 2015.03.12.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLInterest.h"

@class NPInterestViewCell;
@protocol NPInterestViewCellDelegate <NSObject>

- (void)toggleCheckBox:(NPInterestViewCell *)interestViewCell;

@end

@interface NPInterestViewCell : UICollectionViewCell

@property (nonatomic, assign) id<NPInterestViewCellDelegate> delegate;
@property (readwrite, assign, nonatomic) BOOL editModeOn;
@property (readwrite, strong, nonatomic) CLInterest *interest;
@property (nonatomic) UIImageView *imageView;
@property (nonatomic) UILabel *titleLbl;
@property (nonatomic) UIImageView *checkboxImg;

- (void)toggleCheckbox:(BOOL)isMember;

@end
