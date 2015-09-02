//
//  CLHomeTableViewController.m
//  Cooleaf
//
//  Created by Haider Khan on 8/31/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "CLHomeTableViewController.h"
#import "UIColor+CustomColors.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface CLHomeTableViewController () {
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
    
    // Init SearchDisplay
    [self searchDisplay];
    
    // Init nav bar color
    self.navigationController.navigationBar.barTintColor = [UIColor colorPrimary];
    self.navigationController.navigationBar.tintColor = [UIColor colorPrimaryDark];
    
    // Init pull to refresh
    [self initPullToRefresh];
    
    // Init auth presenter
    _authPres = [[CLAuthenticationPresenter alloc] initWithInteractor:self];
    [_authPres registerOnBus];
    [_authPres authenticate:@"kevin.coleman@sparkstart.io" :@"passwordpassword"];
    
    // Init event presenter
    [self initPresenter];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 600.0;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - searchDisplay

-(void)searchDisplay {
    
    // place search bar coordinates where the navbar is position - offset by statusbar
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 20, 320, 44)];
    
    self.searchController = [[UISearchDisplayController alloc] initWithSearchBar:self.searchBar contentsController:self];
    //self.searchController.searchResultsDataSource = self;
    //self.searchController.searchResultsDelegate = self;
    self.searchController.delegate = self;
    
    // Do any additional setup after loading the view.
    
    UIBarButtonItem *searchBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(toggleSearch)];
    
    
    UIBarButtonItem *commentBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:nil];
    
    
    NSArray * rightButtons = [NSArray arrayWithObjects:searchBtn,commentBtn, nil];
    
    [[self navigationItem] setRightBarButtonItems:(rightButtons) animated:YES];
    
    searchBtn.tintColor = [UIColor whiteColor];
    commentBtn.tintColor = [UIColor whiteColor];
}
#pragma mark - toggleSearch

- (void)toggleSearch
{
    [self.tableView addSubview:self.searchBar];
    [self.searchController setActive:YES animated:YES];
    [self.searchBar becomeFirstResponder];
    self.searchBar.barTintColor = barColor;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
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
    _user = user;
    [self initProfileHeaderWithUser:_user];
    [_eventPresenter loadEvents];
}

# pragma mark - IEventInteractor methods

- (void)initEvents:(NSMutableArray *)events {
    // Events receieved here, set into tableview
    _events = events;
    [self.tableView numberOfRowsInSection:[_events count]];
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
    
    // If refreshing end refreshing
    if (self.refreshControl) {
        [self setAttributedTitle];
        [self.refreshControl endRefreshing];
    }
}

# pragma mark - initPresenter

- (void)initPresenter {
    _eventPresenter = [[CLEventPresenter alloc] initWithInteractor:self];
    [_eventPresenter registerOnBus];
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

- (void)initPullToRefresh {
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor colorAccent];
    self.refreshControl.tintColor = [UIColor whiteColor];
    [self.refreshControl addTarget:self
                            action:@selector(reloadEvents)
                  forControlEvents:UIControlEventValueChanged];
}

- (void)initProfileHeaderWithUser:(CLUser *)user {
    _userNameLabel.text = [user userName];
    _userRewardsLabel.text = [NSString stringWithFormat:@"%@ %@", @"Reward Points:", [[user rewardPoints] stringValue]];
    
    NSDictionary *userDict = [user dictionaryValue];
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
    messageLabel.textColor = [UIColor blackColor];
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
    NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObject:[UIColor whiteColor]
                                                                forKey:NSForegroundColorAttributeName];
    NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:title attributes:attrsDictionary];
    self.refreshControl.attributedTitle = attributedTitle;
}

@end
