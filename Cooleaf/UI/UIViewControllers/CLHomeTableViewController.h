//
//  CLHomeTableViewController.h
//  Cooleaf
//
//  Created by Haider Khan on 8/31/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLEventCell.h"
#import "IAuthenticationInteractor.h"
#import "IEventInteractor.h"
#import "CLAuthenticationPresenter.h"
#import "CLEventPresenter.h"

@interface CLHomeTableViewController : UITableViewController <CLEventCellDelegate, IAuthenticationInteractor, IEventInteractor,
                                                        UIGestureRecognizerDelegate, UITableViewDataSource, UITableViewDelegate,UISearchDisplayDelegate>

@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UISearchDisplayController *searchController;
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userCredentialsLabel;
@property (weak, nonatomic) IBOutlet UILabel *userRewardsLabel;

-(void)searchDisplay;

@end
