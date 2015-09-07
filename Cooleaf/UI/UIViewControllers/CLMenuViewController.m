//
//  CLMenuViewController.m
//  Cooleaf
//
//  Created by Haider Khan on 8/31/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "CLMenuViewController.h"
#import "UIColor+CustomColors.h"

@interface CLMenuViewController () {
    @private
    NSArray *titles;
    NSArray *titles2;
    NSArray *icons;
    NSArray *icons2;
    UIColor *textColor;
}

@end

@implementation CLMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self setupTableViewUIData];
    [self setupTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UITableView Delegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = textColor;
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:17];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)sectionIndex {
    if (sectionIndex == 0)
        return nil;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 34)];
    view.backgroundColor = textColor;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 8, 0, 0)];
    //label.text = @"Friends Online";
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = textColor;
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
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex {
    if (sectionIndex == 0)
        return titles.count;
    else
        return titles2.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    
    if (indexPath.section == 0) {
        cell.textLabel.text = titles[indexPath.row];
        cell.imageView.image = [UIImage imageNamed:icons[indexPath.row]];
    } else {
        cell.textLabel.text = titles2[indexPath.row];
    }
    return cell;
}

# pragma mark - setupTableView Methods

- (void)setupTableViewUIData {
    textColor = [UIColor menuTextColor];
    titles = @[@"Home", @"My Events", @"Groups",@"People",@"My Profile"];
    titles2 = @[@"#Running", @"#Picnicholiday2015", @"#Walking"];
    icons = @[@"home-1",@"calendar",@"Profile",@"Profile",@"Profile"];
    icons2 = @[@"Profile"];
}

- (void)setupTableView {
    
    self.tableView.separatorColor = [UIColor colorWithRed:150/255.0f green:161/255.0f blue:177/255.0f alpha:1.0f];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.opaque = NO;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.tableHeaderView = ({
        
        // Initialize Header Views
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 184.0f)];
        // Header ImageView
        UIImageView *imageView = [self setupHeaderImage];
        //Border
        UIView *border = [self setupHeaderBorder];
        //Name
        UILabel *labelName = [self setupHeaderLabelName];
        //Orginization
        UILabel *labelOrganization = [self setupHeaderOrganizationLabel];
        //Rewards
        int rewardPoints = 0;
        UILabel *labelRewards = [self setupHeaderRewardsLabel:rewardPoints];
        
        // Add views
        [view addSubview:imageView];
        [view addSubview:labelName];
        [view addSubview:labelOrganization];
        [view addSubview:labelRewards];
        [view addSubview:border];
        view;
        
    });
}

# pragma mark - TableView Helper Methods

- (UIImageView *)setupHeaderImage {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(-5, 20, 70, 70)];
    imageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    imageView.image = [UIImage imageNamed:@"TestImage"];
    imageView.layer.masksToBounds = YES;
    imageView.layer.cornerRadius = imageView.frame.size.height/2;
    imageView.layer.borderColor = [UIColor clearColor].CGColor;
    imageView.layer.borderWidth = 3.0f;
    imageView.layer.rasterizationScale = [UIScreen mainScreen].scale;
    imageView.layer.shouldRasterize = YES;
    imageView.clipsToBounds = YES;
    return imageView;
}

- (UIView *)setupHeaderBorder {
    UIView *border = [[UIView alloc] initWithFrame:CGRectMake(0, 180, 400, 0.5)];
    border.backgroundColor = textColor;
    return border;
}

- (UILabel *)setupHeaderLabelName {
    UILabel *labelName = [[UILabel alloc] initWithFrame:CGRectMake(-7, 100, 0, 0)];
    labelName.textAlignment = NSTextAlignmentLeft;
    labelName.text = @"Prem Bhatia";
    labelName.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
    labelName.backgroundColor = [UIColor clearColor];
    labelName.textColor = textColor;
    [labelName sizeToFit];
    labelName.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    return labelName;
}

- (UILabel *)setupHeaderOrganizationLabel {
    UILabel *labelOrganization = [[UILabel alloc] initWithFrame:CGRectMake(-3.5, 120, 0, 0)];
    labelOrganization.textAlignment = NSTextAlignmentLeft;
    labelOrganization.text = @"Cooleaf";
    labelOrganization.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
    labelOrganization.backgroundColor = [UIColor clearColor];
    labelOrganization.textColor = textColor;
    [labelOrganization sizeToFit];
    labelOrganization.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    return labelOrganization;
}

- (UILabel *)setupHeaderRewardsLabel:(int)rewardPoints {
    UILabel *rewardsLabel = [[UILabel alloc] initWithFrame:CGRectMake(-5, 140, 0, 0)];
    rewardsLabel.textAlignment = NSTextAlignmentLeft;
    rewardsLabel.text = [NSString stringWithFormat:@"Rewards:%d", rewardPoints];
    rewardsLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
    rewardsLabel.backgroundColor = [UIColor clearColor];
    rewardsLabel.textColor = textColor;
    [rewardsLabel sizeToFit];
    rewardsLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    return rewardsLabel;
}

@end
