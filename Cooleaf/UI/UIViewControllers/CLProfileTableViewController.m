//
//  CLProfileTableViewController.m
//  Cooleaf
//
//  Created by Haider Khan on 9/3/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "CLProfileTableViewController.h"
#import "CLInformationTableViewcell.h"
#import "CLEventCell.h"
#import "CLGroupTableViewCell.h"
#import "CLClient.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation CLProfileTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Go ahead and init the profile header with the user
    [self initProfileHeaderWithUser:_user];
    
    self.tableView.rowHeight = [self height];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.segmentedBar addTarget:self action:@selector(segmentChanged) forControlEvents:UIControlEventValueChanged];
}

- (void)segmentChanged {
    self.tableView.rowHeight = [self height];
    [self.tableView reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

# pragma mark - TableView DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Switch statement based on TableView or CollectionView - number of rows
    // Note that Obj C compiler won't work in switch statement without ';' in from of case label
    switch (self.segmentedBar.selectedSegmentIndex) {
        case 0:;
            // Number of rows in information
            return 0;
        case 1:;
            // Number of rows in History
            return 0;
        case 2:;
            // 1 row for collectionview inside cell
            return 1;
        default:
            return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // Note that Obj C compiler won't work in switch statement without ';' in from of case label
    switch (self.segmentedBar.selectedSegmentIndex) {
        case 0:;
            // Declare information tableviewcell here
            return nil;
        case 1:;
            // Declare history tableviewcell here
            return nil;
        case 2:;
            CLGroupTableViewCell *groupCell = [self.tableView dequeueReusableCellWithIdentifier:@"groupCell" forIndexPath:indexPath];
            groupCell.user = _user;
            return groupCell;
    }
    return nil;
}

# pragma mark - Helper Methods

- (CGFloat)height {
    // Switch statement here on different segments for height
    switch (self.segmentedBar.selectedSegmentIndex) {
        case 2:;
            return [CLGroupTableViewCell getHeightForUser:_user];
        default:
            return UITableViewAutomaticDimension;
    }
}

- (void)initProfileHeaderWithUser:(CLUser *)user {
    _userNameLabel.text = [user userName];
    _userRewardsLabel.text = [NSString stringWithFormat:@"%@ %@", @"Reward Points:", [[user rewardPoints] stringValue]];
    
    // Load user image into blurry background image, and blur it
    
    
    // Load user image into avatar imageview
    NSDictionary *userDict = [user dictionaryValue];
    NSString *fullImagePath = [NSString stringWithFormat:@"%@%@", [CLClient getBaseApiURL], userDict[@"profile"][@"picture"][@"original"]];
    [_userImage sd_setImageWithURL:[NSURL URLWithString: fullImagePath] placeholderImage:[UIImage imageNamed:@"AvatarPlaceholderMaleMedium"]];
    _userImage.layer.cornerRadius = _userImage.frame.size.width / 2;
    _userImage.clipsToBounds = YES;
}

@end
