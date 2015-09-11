//
//  CLGroupViewController.m
//  Cooleaf
//
//  Created by Jonathan Green on 9/3/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import <SDWebImage/UIImageView+WebCache.h>
#import "CLGroupViewController.h"
#import "UIColor+CustomColors.h"
#import "CLGroupDetailViewController.h"
#import "CLInterestPresenter.h"
#import "CLInterest.h"

@interface CLGroupViewController () {
    @private
    UIRefreshControl *_refreshControl;
    CLInterestPresenter *_interestPresenter;
    NSMutableArray *_interests;
    UIColor *_barColor;
}

@end

@implementation CLGroupViewController

# pragma mark - LifeCycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSearch];
    [self initPullToRefresh];
    
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)viewWillAppear:(BOOL)animated {
    [self setupNavBar];
    [self initInterestPresenter];
}

- (void)viewDidAppear:(BOOL)animated {
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [_interestPresenter unregisterOnBus];
    _interestPresenter = nil;
}

- (void)viewDidDisappear:(BOOL)animated {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - searchDisplay

-(void)setupSearch {
    UIBarButtonItem *searchBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:nil];
    UIBarButtonItem *commentBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:nil];

    NSArray * rightButtons = [NSArray arrayWithObjects:searchBtn,commentBtn, nil];
    
    [[self navigationItem] setRightBarButtonItems:(rightButtons) animated:YES];
    
    searchBtn.tintColor = [UIColor whiteColor];
    commentBtn.tintColor = [UIColor whiteColor];
}

# pragma mark - initPullToRefresh

- (void)initPullToRefresh {
    _refreshControl = [UIRefreshControl new];
    [_refreshControl addTarget:self action:@selector(reloadInterests) forControlEvents:UIControlEventValueChanged];
    _refreshControl.tintColor = [UIColor groupNavBarColor];
    [self.tableView addSubview:_refreshControl];
    [self.tableView sendSubviewToBack:_refreshControl];
}

# pragma mark - setupNavBar

- (void)setupNavBar {
    self.navigationController.navigationBar.alpha = 1;
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:UITextAttributeTextColor];
    _barColor = [UIColor groupNavBarColor];
    self.navigationController.navigationBar.barTintColor = _barColor;
}

# pragma mark - initInterestPresenter

- (void)initInterestPresenter {
    _interestPresenter = [[CLInterestPresenter alloc] initWithInteractor:self];
    [_interestPresenter registerOnBus];
    [_interestPresenter loadInterests];
}

# pragma mark - IInterestInteractor Methods

- (void)initInterests:(NSMutableArray *)interests {
    _interests = interests;
    [self.tableView reloadData];
    
    // If refreshing end refreshing
    if (_refreshControl) {
        [self setAttributedTitle];
        [_refreshControl endRefreshing];
    }
}

/*#pragma mark - Search

- (void)SearchViewController {
    
    CLSearchViewController *search = [self.storyboard instantiateViewControllerWithIdentifier:@"search"];
    
    //searchomtroller
    [[self navigationController] pushViewController:search animated:YES];
}*/

# pragma mark - TableView Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _interests.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CLGroupCell *cell = [tableView dequeueReusableCellWithIdentifier:@"groupCell"];
    
    // Grab interest
    CLInterest *interest = [_interests objectAtIndex:indexPath.row];
    
    // Get name and image
    NSString *name = [interest name];
    CLImage *image = [interest image];
    
    // Get image path
    NSString *url = [image url];
    NSString *fullPath = [NSString stringWithFormat:@"%@%@", @"http:", url];
    fullPath = [fullPath stringByReplacingOccurrencesOfString:@"{{SIZE}}" withString:@"1600x400"];
    
    // Set image
    [cell.groupImageView sd_setImageWithURL:[NSURL URLWithString:fullPath]
                           placeholderImage:[UIImage imageNamed:@"placeholder.png"]];
    
    // Set name
    cell.labelName.text = name;
    
    [cell setAccessoryType:UITableViewCellAccessoryNone];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

# pragma mark - configureGroupCell

- (CLGroupCell *)configureGroupCell:(CLGroupCell *)groupCell indexPath:(NSIndexPath *)indexPath {
    [groupCell.imageView sd_setImageWithURL:[self getInterestImageURL:[indexPath row]]
                           placeholderImage:[UIImage imageNamed:nil]];
    
    return groupCell;
}

# pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"toDetail"]) {
        [self goToDetailView:segue];
    }
}

# pragma mark - reloadInterests

- (void)reloadInterests {
    if (_interestPresenter != nil)
        [_interestPresenter loadInterests];
}

# pragma mark - goToDetailView

- (void)goToDetailView:(UIStoryboardSegue *)segue {
    CLGroupDetailViewController *detailView = (CLGroupDetailViewController *)[segue destinationViewController];
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    
    CLInterest *interest = [_interests objectAtIndex:[indexPath row]];
    CLImage *image = [interest image];
    
    // Get image path
    NSString *url = [image url];
    NSString *fullPath = [NSString stringWithFormat:@"%@%@", @"http:", url];
    fullPath = [fullPath stringByReplacingOccurrencesOfString:@"{{SIZE}}" withString:@"1600x400"];

    NSString *currentName = [interest name];
    
    detailView.currentImagePath = fullPath;
    detailView.currentName = currentName;
}

- (void)setAttributedTitle {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM d, h:mm a"];
    NSString *title = [NSString stringWithFormat:@"Last update: %@", [formatter stringFromDate:[NSDate date]]];
    NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObject:[UIColor groupNavBarColor]
                                                                forKey:NSForegroundColorAttributeName];
    NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:title attributes:attrsDictionary];
    _refreshControl.attributedTitle = attributedTitle;
}

- (NSURL *)getInterestImageURL:(NSUInteger)row {
    CLInterest *interest = [_interests objectAtIndex:row];
    CLImage *image = [interest image];
    NSString *url = [image url];
    NSString *fullPath = [NSString stringWithFormat:@"%@%@", @"http:", url];
    fullPath = [fullPath stringByReplacingOccurrencesOfString:@"{{SIZE}}" withString:@"164x164"];
    NSLog(@"%@", fullPath);
    return [NSURL URLWithString:fullPath];
}

@end
