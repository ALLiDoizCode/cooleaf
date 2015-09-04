//
//  CLProfileTableViewController.h
//  Cooleaf
//
//  Created by Haider Khan on 9/3/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLUser.h"

@interface CLProfileTableViewController : UITableViewController

@property (nonatomic) CLUser *user;
@property (weak, nonatomic) IBOutlet UIImageView *blurImage;
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userCredentialsLabel;
@property (weak, nonatomic) IBOutlet UILabel *userRewardsLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedBar;

@end
