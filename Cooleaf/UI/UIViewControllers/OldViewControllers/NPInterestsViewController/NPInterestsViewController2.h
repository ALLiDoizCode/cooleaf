//
//  NPInterestsViewController.h
//  Cooleaf
//
//  Created by Curtis Jones on 2015.03.12.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IInterestInteractor.h"
#import "IFilePreviewInteractor.h"
#import "IUserInteractor.h"
#import "NPInterestViewCell.h"
#import "CLUser.h"

@interface NPInterestsViewController2 : UICollectionViewController <IInterestInteractor, IFilePreviewsInteractor, IUserInteractor, NPInterestViewCellDelegate>

@property (readwrite, strong, nonatomic) CLUser *user;
@property (nonatomic, strong) UIImage *userAvatar;
@property (readwrite, assign, nonatomic) BOOL editModeOn;
@property (readwrite, assign, nonatomic) BOOL topBarEnabled;
@property (readwrite, assign, nonatomic) BOOL scrollEnabled;

@end
