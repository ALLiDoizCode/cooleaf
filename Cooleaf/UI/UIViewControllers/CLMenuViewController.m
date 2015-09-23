//
//  CLMenuViewController.m
//  Cooleaf
//
//  Created by Haider Khan on 8/31/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import <SDWebImage/UIImageView+WebCache.h>
#import "CLMenuViewController.h"
#import "UIColor+CustomColors.h"
#import "CLClient.h"
#import "CLPeopleViewController.h"
#import "NPAppDelegate.h"

@interface CLMenuViewController () {
    @private
    NSArray *titles;
    NSArray *titles2;
    NSArray *icons;
    NSArray *icons2;
    UIColor *textColor;
    UIImageView *userImageView;
    UILabel *userNameLabel;
    UILabel *userCredentialsLabel;
    UILabel *userRewardsLabel;
}

@end

@implementation CLMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableViewUIData];
    [self setupTableView];
    
    self.navigationController.navigationBarHidden = YES;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    titles = @[@"Home", @"My Events", @"Groups",@"People",@"My Profile"];
    
    icons = @[@"Profile",@"Profile",@"Profile",@"Profile",@"Profile"];
    icons2 = @[@"Profile"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableView Delegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor offWhite];
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:17];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)sectionIndex {
    if (sectionIndex == 0)
        return nil;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 34)];
    view.backgroundColor = [UIColor offWhite];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 8, 0, 0)];
    //label.text = @"Friends Online";
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = [UIColor offWhite];
    label.backgroundColor = [UIColor offWhite];
    [label sizeToFit];
    [view addSubview:label];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)sectionIndex {
    if (sectionIndex == 0)
        return 0;

    return 0.5;
}

#pragma mark UITableView Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 54;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex {
    return [titles count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    
    if (indexPath.section == 0) {
        cell.textLabel.text = titles[indexPath.row];
        cell.imageView.image = [UIImage imageNamed:icons[indexPath.row]];
    }
    
    return cell;
}

# pragma mark - setupTableView Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    CLNavigation *navigateTo = [[CLNavigation alloc] init];
    
    switch(indexPath.row) {
        case 0:
            [navigateTo homeController] ;
            break;
        case 1:
           [navigateTo myEventController];
            break;
        case 2:
            [navigateTo groupController];
            break;
        case 3:
            [navigateTo peopleController];
            break;
        case 4:
            NSLog(@"4" );
            break;
        default:
            break;
    }
}

# pragma mark - initTableView

- (void)setupTableViewUIData {
    textColor = [UIColor menuTextColor];
    titles = @[@"Home", @"My Events", @"Groups",@"People",@"My Profile"];
    icons = @[@"home-1",@"calendar",@"Profile",@"Profile",@"Profile"];
    icons2 = @[@"Profile"];
}

- (void)setupTableView {
    self.tableView.separatorColor = [UIColor colorWithRed:150/255.0f green:161/255.0f blue:177/255.0f alpha:1.0f];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.opaque = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
}

# pragma mark - initUserInHeaderView

- (void)initUserInHeaderView:(CLUser *)user {
    
    // Get user dictionary
    NSDictionary *userDict = [user dictionaryValue];
    
    // Get info
    NSString *userName = [user userName];
    NSString *userCredentials = userDict[@"role"][@"organization"][@"name"];
    NSString *rewardPoints = [[user rewardPoints] stringValue];
    NSString *fullImagePath = [NSString stringWithFormat:@"%@%@", [CLClient getBaseApiURL], userDict[@"profile"][@"picture"][@"original"]];

    self.tableView.tableHeaderView = ({
        // Initialize Header Views
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 184.0f)];
        // Header ImageView
        userImageView = [self setupHeaderImage];
        [userImageView sd_setImageWithURL:[NSURL URLWithString: fullImagePath] placeholderImage:[UIImage imageNamed:@"AvatarPlaceholderMaleMedium"]];
        
        // Name
        userNameLabel = [self setupHeaderLabelName:userName];
        
        // Organization
        userCredentialsLabel = [self setupHeaderOrganizationLabel:userCredentials];
        
        // Rewards
        userRewardsLabel = [self setupHeaderRewardsLabel:rewardPoints];
        
        // Add views
        [view addSubview:userImageView];
        [view addSubview:userNameLabel];
        [view addSubview:userCredentialsLabel];
        [view addSubview:userRewardsLabel];
        view;
    });
}

# pragma mark - TableView Helper Methods

- (UIImageView *)setupHeaderImage {
    userImageView = [[UIImageView alloc] initWithFrame:CGRectMake(-5, 20, 70, 70)];
    userImageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    userImageView.contentMode = UIViewContentModeScaleAspectFill;
    userImageView.layer.masksToBounds = YES;
    userImageView.layer.cornerRadius = userImageView.frame.size.height/2;
    userImageView.layer.borderColor = [UIColor clearColor].CGColor;
    userImageView.layer.borderWidth = 3.0f;
    userImageView.layer.rasterizationScale = [UIScreen mainScreen].scale;
    userImageView.layer.shouldRasterize = YES;
    userImageView.clipsToBounds = YES;
    
    return userImageView;
}

- (UILabel *)setupHeaderLabelName:(NSString *)userName {
    userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 100, 0, 0)];
    userNameLabel.textAlignment = NSTextAlignmentLeft;
    userNameLabel.text = userName;
    userNameLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
    userNameLabel.backgroundColor = [UIColor clearColor];
    userNameLabel.textColor = textColor;
    [userNameLabel sizeToFit];
    userNameLabel.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
    return userNameLabel;
}

- (UILabel *)setupHeaderOrganizationLabel:(NSString *)userCredentials {
    userCredentialsLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 120, 0, 0)];
    userCredentialsLabel.textAlignment = NSTextAlignmentLeft;
    userCredentialsLabel.text = userCredentials;
    userCredentialsLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
    userCredentialsLabel.backgroundColor = [UIColor clearColor];
    userCredentialsLabel.textColor = textColor;
    [userCredentialsLabel sizeToFit];
    userCredentialsLabel.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
    return userCredentialsLabel;
}

- (UILabel *)setupHeaderRewardsLabel:(NSString *)rewardPoints {
    userRewardsLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 140, 0, 0)];
    userRewardsLabel.textAlignment = NSTextAlignmentLeft;
    userRewardsLabel.text = [NSString stringWithFormat:@"%@ %@", @"Reward Points:", rewardPoints];
    userRewardsLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
    userRewardsLabel.backgroundColor = [UIColor clearColor];
    userRewardsLabel.textColor = textColor;
    [userRewardsLabel sizeToFit];
    userRewardsLabel.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
    return userRewardsLabel;
}

@end
