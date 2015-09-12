//
//  CLHomeTableViewController.m
//  Cooleaf
//
//  Created by Haider Khan on 8/31/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import <SDWebImage/UIImageView+WebCache.h>
#import <UIViewController+MMDrawerController.h>
#import "CLHomeTableViewController.h"
#import "UIColor+CustomColors.h"
#import "CLProfileTableViewController.h"
#import "CLPostViewController.h"
#import "CLAuthenticationPresenter.h"
#import "CLEventPresenter.h"
#import "CLEvent.h"
#import "CLClient.h"
#import "CLSearchViewController.h"
#import "CLEventController.h"
#import "NPAppDelegate.h"

@interface CLHomeTableViewController() {
    @private
    CLAuthenticationPresenter *_authPres;
    CLEventPresenter *_eventPresenter;
    CLUser *_user;
    NSMutableArray *_events;
    UIColor *barColor;
}

@end

@implementation CLHomeTableViewController

# pragma mark - UIViewController LifeCycle methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Searchbar color
    barColor = [UIColor UIColorFromRGB:0x69C4BB];
    
    // Init bar display
    [self setupDisplay];
    
    // Init nav bar color
    self.navigationController.navigationBar.barTintColor = [UIColor colorPrimary];
    self.navigationController.navigationBar.tintColor = [UIColor colorPrimaryDark];

    [self initViews];
    [self initUserImageGestureRecognizer];
    
    // Init pull to refresh
    [self initPullToRefresh];
    
    // Init auth presenter
    [self initAuthPresenter];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self initPresenter];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_eventPresenter unregisterOnBus];
    _eventPresenter = nil;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - setupDisplay

-(void)setupDisplay {
    // Do any additional setup after loading the view.
    UIBarButtonItem *searchBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(searchViewController)];
    
    UIBarButtonItem *commentBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(postViewController)];
    
    NSArray *rightButtons = [NSArray arrayWithObjects:searchBtn, commentBtn, nil];
    [[self navigationItem] setRightBarButtonItems:(rightButtons) animated:YES];
    
    searchBtn.tintColor = [UIColor whiteColor];
    commentBtn.tintColor = [UIColor whiteColor];
}

# pragma mark - postViewController

- (void)postViewController {
    CLPostViewController *post = [self.storyboard instantiateViewControllerWithIdentifier:@"Post"];
    [[self navigationController] presentViewController:post animated:YES completion:nil];
}

#pragma mark - toggleSearch

- (void)toggleSearch {
    [self.tableView addSubview:self.searchBar];
    [self.searchController setActive:YES animated:YES];
    [self.searchBar becomeFirstResponder];
    self.searchBar.barTintColor = barColor;
}

# pragma mark - searchViewController

- (void)searchViewController {
    CLSearchViewController *search = [self.storyboard instantiateViewControllerWithIdentifier:@"search"];
    [[self navigationController] pushViewController:search animated:YES];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"Profile Segue"]) {
        ((CLProfileTableViewController *) segue.destinationViewController).user = _user;
    }
}

# pragma mark - CLEventCellDelegate

- (void)didPressComment:(CLEventCell *)cell {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    CLEvent *event = [_events objectAtIndex:[indexPath row]];
    
    // Add a comment
}

- (void)didPressJoin:(CLEventCell *)cell {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    CLEvent *event = [_events objectAtIndex:[indexPath row]];
    
    // Join event
}

# pragma mark - IAuthenticationInteractor methods

- (void)initUser:(CLUser *)user {
    
    // Init user to the navigation drawer
    
    _user = user;
    [self initProfileHeaderWithUser:_user];
    [_eventPresenter loadEvents];
}

# pragma mark - IEventInteractor methods

- (void)initEvents:(NSMutableArray *)events {
    // Events receieved here, set into tableview
    _events = events;
    [self.tableView reloadData];
    
    // If refreshing end refreshing
    if (self.refreshControl) {
        [self setAttributedTitle];
        [self.refreshControl endRefreshing];
    }
}

- (void)initUserEvents:(NSMutableArray *)userEvents {
    // Used for handled back navigation from Profile when loading user events.
}

# pragma mark - Init Presenters

- (void)initPresenter {
    _eventPresenter = [[CLEventPresenter alloc] initWithInteractor:self];
    [_eventPresenter registerOnBus];
}

- (void)initAuthPresenter {
    // Init auth presenter
    _authPres = [[CLAuthenticationPresenter alloc] initWithInteractor:self];
    [_authPres registerOnBus];
    [_authPres authenticate:@"kevin.coleman@sparkstart.io" :@"passwordpassword"];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [_events count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CLEventCell *cell = [tableView dequeueReusableCellWithIdentifier:@"eventCell" forIndexPath:indexPath];
    cell.delegate = self;
    
    // Set cell shadow
    cell.layer.shadowOpacity = 0.75f;
    cell.layer.shadowRadius = 1.0;
    cell.layer.shadowOffset = CGSizeMake(0, 0);
    cell.layer.shadowColor = [UIColor blackColor].CGColor;
    cell.layer.zPosition = 777;
    
    // Get the event
    CLEvent *event = [_events objectAtIndex:[indexPath row]];
    
    // Get the image url
    CLImage *eventImage = [event eventImage];
    NSString *imageUrl = eventImage.url;
    NSString *fullPath = [NSString stringWithFormat:@"%@%@", @"http:", imageUrl];
    fullPath = [fullPath stringByReplacingOccurrencesOfString:@"{{SIZE}}" withString:@"500x200"];
    
    // Set it into the imageview
    [cell.eventImage sd_setImageWithURL:[NSURL URLWithString:fullPath]
                       placeholderImage:[UIImage imageNamed:@"CoverPhotoPlaceholder"]];
    
    // Get the event description
    NSString *eventDescription = [event eventDescription];
    
    cell.eventDescription.text = eventDescription;
    
    return cell;
}

// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}

// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}

# pragma mark - Helper Methods

- (void)initViews {
    // Init nav bar color
    self.navigationController.navigationBar.barTintColor = [UIColor colorPrimary];
    self.navigationController.navigationBar.tintColor = [UIColor colorPrimaryDark];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 600.0;
}

- (void)initUserImageGestureRecognizer {
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTap)];
    tapRecognizer.numberOfTapsRequired = 1;
    tapRecognizer.numberOfTouchesRequired = 1;
    tapRecognizer.delegate = self;
    [_userImage addGestureRecognizer:tapRecognizer];
    _userImage.userInteractionEnabled = YES;
}

- (void)onTap {
    // Go to profile view controller
    [self goToProfileView];
}

- (void)goToProfileView {
    [self performSegueWithIdentifier:@"Profile Segue" sender:self];
}

- (void)initPullToRefresh {
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor clearColor];
    self.refreshControl.tintColor = [UIColor colorAccent];
    [self.refreshControl addTarget:self
                            action:@selector(reloadEvents)
                  forControlEvents:UIControlEventValueChanged];
}

- (void)initProfileHeaderWithUser:(CLUser *)user {
    _userNameLabel.text = [user userName];
    _userRewardsLabel.text = [NSString stringWithFormat:@"%@ %@", @"Reward Points:", [[user rewardPoints] stringValue]];
    
    // Get user dictionary
    NSDictionary *userDict = [user dictionaryValue];
    
    // Get credentuals from dictionary
    _userCredentialsLabel.text = userDict[@"role"][@"organization"][@"name"];
    
    NSString *fullImagePath = [NSString stringWithFormat:@"%@%@", [CLClient getBaseApiURL], userDict[@"profile"][@"picture"][@"original"]];
    [_userImage sd_setImageWithURL:[NSURL URLWithString: fullImagePath] placeholderImage:[UIImage imageNamed:@"AvatarPlaceholderMaleMedium"]];
    _userImage.layer.cornerRadius = _userImage.frame.size.width / 2;
    _userImage.clipsToBounds = YES;
}

- (void)reloadEvents {
    [_eventPresenter loadEvents];
}

- (void)displayEmptyMessage {
    UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    
    messageLabel.text = @"No events currently available. Please pull down to refresh.";
    messageLabel.textColor = [UIColor darkGrayColor];
    messageLabel.numberOfLines = 0;
    messageLabel.textAlignment = NSTextAlignmentCenter;
    messageLabel.font = [UIFont fontWithName:@"Palatino-Italic" size:12];
    [messageLabel sizeToFit];
    
    self.tableView.backgroundView = messageLabel;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)setAttributedTitle {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM d, h:mm a"];
    NSString *title = [NSString stringWithFormat:@"Last update: %@", [formatter stringFromDate:[NSDate date]]];
    NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObject:[UIColor colorAccent]
                                                                forKey:NSForegroundColorAttributeName];
    NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:title attributes:attrsDictionary];
    self.refreshControl.attributedTitle = attributedTitle;
}

@end
