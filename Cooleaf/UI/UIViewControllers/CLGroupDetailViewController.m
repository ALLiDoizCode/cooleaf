//
//  CLGroupDetailViewController.m
//  Cooleaf
//
//  Created by Jonathan Green on 9/4/15.
//  Edited by Haider Khan on 9/10/15
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import <SDWebImage/UIImageView+WebCache.h>
#import "CLGroupDetailViewController.h"
#import "UIColor+CustomColors.h"
#import "CCColorCube.h"
#import "CLEventCell.h"
#import "CLGroupDetailCollectionCell.h"
#import "CLInterestPresenter.h"
#import "CLGroupPostViewcontroller.h"
#import "CLUser.h"
#import "UIImageView+WebCache.h"
#import "CLClient.h"
#import "CLSearchViewController.h"
#import "CLFeedPresenter.h"
#import "CLFeed.h"
#import "CLNavigation.h"

@interface CLGroupDetailViewController()

@property (assign) int currentIndex;
@property (nonatomic) CLInterestPresenter *interestPresenter;
@property (nonatomic) CLFeedPresenter *feedPresenter;
@property (nonatomic) UIColor *barColor;
@property (nonatomic) NSMutableArray *feeds;
@property (nonatomic) NSMutableArray *events;
@property (nonatomic) NSMutableArray *members;

@end

@implementation CLGroupDetailViewController

# pragma mark - LifeCycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Selector to go to people view controller
    [self.detailView.members addTarget:self action:@selector(goToPeopleController) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationController.navigationBar.tintColor = [UIColor offWhite];
    
    [self setupSearch];
    [self setupTableView];
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setupInterestPresenter];
    [self setupFeedPresenter];
    if (_currentImagePath)
        [self grabColorFromImage];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    // Remove title when coming back from members
    self.navigationController.navigationBar.topItem.title = @"";
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_interestPresenter unregisterOnBus];
    _interestPresenter = nil;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma mark - goToPeopleController

-(void)goToPeopleController{
    CLNavigation *navigateTo = [[CLNavigation alloc] init];
    [navigateTo interestPeopleController:self.navigationController interest:_interest];
}

#pragma mark - searchDisplay

-(void)setupSearch {
    
    // Set text on navbar to white
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:UITextAttributeTextColor];
    
    // Set nav bar color
    _barColor = [UIColor searchNavBarColor];
    self.navigationController.navigationBar.barTintColor = _barColor;
    
    // Set buttons
    UIBarButtonItem *searchBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(searchViewController)];
    UIBarButtonItem *commentBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:nil];
    NSArray * rightButtons = [NSArray arrayWithObjects:searchBtn,commentBtn, nil];
    [[self navigationItem] setRightBarButtonItems:(rightButtons) animated:YES];
    
    // Set nav bar button colors
    searchBtn.tintColor = [UIColor whiteColor];
    commentBtn.tintColor = [UIColor whiteColor];
}

# pragma mark - setupTableView

- (void)setupTableView {
    if (self.tableView != nil) {
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        // Assign estimated and automatic dimension for dynamic resizing of cell
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.estimatedRowHeight = 140;
        [self.tableView reloadData];
    }
}

# pragma mark - setupUI

- (void)setupUI {
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    // Set size for ScrollView
    [_detailScroll setContentSize:CGSizeMake(_detailScroll.contentSize.width, [self getScrollViewHeight])];
    
    // Set detail view delegate
    _detailView.delegate = self;
    
    // Load image for hero image
    if (_currentImagePath) {
        [_detailView.mainImageView sd_setImageWithURL:[NSURL URLWithString:self.currentImagePath]
                                     placeholderImage:[UIImage imageNamed:nil]];
    }
        
    // Load name for group
    _detailView.labelName.text =[NSString stringWithFormat: @"#%@", _currentName];
    
    // Add number of participants
    [_detailView.members setTitle:[NSString
                         stringWithFormat:@"%d Members >", [[_interest userCount] intValue]]
                         forState:UIControlStateNormal];    
}

# pragma mark - setupGroupPresenter

- (void)setupInterestPresenter {
    _interestPresenter = [[CLInterestPresenter alloc] initWithDetailInteractor:self];
    [_interestPresenter registerOnBus];
    
    // Make a call to grab members
    [_interestPresenter loadInterestMembers:[[_interest interestId] intValue]];
}

# pragma mark - setupFeedPresenter

- (void)setupFeedPresenter {
    _feedPresenter = [[CLFeedPresenter alloc] initWithInteractor:self];
    [_feedPresenter registerOnBus];
    
    // Make a call to grab group feeds
    [_feedPresenter loadInterestFeeds:[[_interest interestId] intValue]];
}

# pragma mark - grabColorFromImage

-(void)grabColorFromImage {
    
    // Get four dominant colors from the image, but avoid the background color of our UI
    CCColorCube *colorCube = [[CCColorCube alloc] init];
    UIImage *img =_detailView.mainImageView.image;
    NSArray *imgColors = [colorCube extractColorsFromImage:img flags:nil];
    _barColor = imgColors[1];
    
    self.navigationController.navigationBar.barTintColor = _barColor;
    self.navigationController.navigationBar.alpha = 0.7;
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:UITextAttributeTextColor];
}

# pragma mark - CLDetailViewDelegate

- (void)selectSegment:(CLDetailView *)detailView {
    _currentIndex = (int) detailView.segmentedControl.selectedSegmentIndex;
    switch (_currentIndex) {
        case 0: {
            // User selected posts, set row height and reload data
            [_detailScroll setContentSize:CGSizeMake(_detailScroll.contentSize.width, [self getScrollViewHeight])];
            //[self.tableView setRowHeight:[self getRowHeight]];
            _tableView.rowHeight = UITableViewAutomaticDimension;
             _tableView.estimatedRowHeight = [self getRowHeight];
            [self.tableView reloadData];
            break;
        }
        case 1: {
            // User selected events
            [_detailScroll setContentSize:CGSizeMake(_detailScroll.contentSize.width, [self getScrollViewHeight])];
            //[self.tableView setRowHeight:[self getRowHeight]];
            _tableView.rowHeight = UITableViewAutomaticDimension;
            _tableView.estimatedRowHeight = [self getRowHeight];
            [self.tableView reloadData];
        }
        default:
            break;
    }
}

- (void)joinGroup:(CLDetailView *)detailView {
    bool isMember = [_interest active];
    if (isMember)
        [_interestPresenter leaveGroup:[[_interest interestId] intValue]];
    else
        [_interestPresenter joinGroup:[[_interest interestId] intValue]];
}

# pragma mark - IInterestDetailInteractor Methods

- (void)initMembers:(NSMutableArray *)members {
    // Add only four members from members list returned from API
    _members = [NSMutableArray new];
    for (int i = 0; i < 4; i++) {
        [_members addObject:[members objectAtIndex:i]];
    }
    
    // Reload collectionview
    [self.collectionView reloadData];
}

# pragma mark - IFeedInteractor Methods

- (void)initFeeds:(NSMutableArray *)feeds {
    _feeds = feeds;
    [self.tableView reloadData];
}

# pragma mark - TableView Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return posts count if user selects posts segment, or events count if user selects events segment
    switch (_currentIndex) {
        case 0:
            return [_feeds count];
        case 1:
            return [_events count];
        default:
            return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (_currentIndex) {
        case 0: {
            // Create the CLGroupPostCell since user is on Posts segment
            CLGroupPostCell *cell = [tableView dequeueReusableCellWithIdentifier:@"groupDetailCell"];
            
            // Get a feed
            CLFeed *feed = [_feeds objectAtIndex:[indexPath row]];
            
            // Get feed dictionary
            NSDictionary *feedDict = [_feeds objectAtIndex:[indexPath row]];
            
            // Set the path and load the image
            NSString *fullImagePath = [NSString stringWithFormat:@"%@%@", [CLClient getBaseApiURL], feedDict[@"user_picture"][@"versions"][@"icon"]];
            [cell.userImage sd_setImageWithURL:[NSURL URLWithString: fullImagePath] placeholderImage:[UIImage imageNamed:@"AvatarPlaceholderMaleMedium"]];
            
            // Set the user name
            NSString *userName = feedDict[@"user_name"];
            cell.labelPostName.text = userName;
            
            // Set the content
            NSString *content = feedDict[@"content"];
            cell.labelPost.text = content;
            
            // Check if feeds comments is not nil or not zero
            NSArray *comments = feedDict[@"comments"];
            if (comments != nil || [comments count] > 0) {
                cell.commentLabel.text = [NSString stringWithFormat:@"%lu comment", (unsigned long) [comments count]];
            } else {
                cell.commentLabel.text = @"0 comments";
            }
            
            return cell;
        }
        case 1: {
            // Create the CLGroupEventCell since user is on Events segment
            CLEventCell *cell = [tableView dequeueReusableCellWithIdentifier:@"groupEventCell"];
            cell.eventDescription.text = @"Sample Event Description";
            return cell;
        }
        default:
            return nil;;
    }
}

# pragma mark - TableView Delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

# pragma mark - Members CollectionView Data Source

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_members count];
}

# pragma mark - Members CollectionView Delegate

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CLGroupDetailCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"detailGroupCollectionCell" forIndexPath:indexPath];
    
    // Get member dictionary
    NSDictionary *userDict = [_members objectAtIndex:[indexPath row]];

    // Get the path and load the image
    NSString *fullImagePath = [NSString stringWithFormat:@"%@%@", [CLClient getBaseApiURL], userDict[@"profile"][@"picture"][@"versions"][@"icon"]];
    [cell.memberImage sd_setImageWithURL:[NSURL URLWithString: fullImagePath] placeholderImage:[UIImage imageNamed:@"AvatarPlaceholderMaleMedium"]];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    // If user touches member photo icon they go to people view controller
    [self goToPeopleController];
}

# pragma mark - searchViewController

- (void)searchViewController {
    CLSearchViewController *search = [self.storyboard instantiateViewControllerWithIdentifier:@"search"];
    [[self navigationController] pushViewController:search animated:YES];
}

# pragma mark - getScrollViewHeight

- (CGFloat)getScrollViewHeight {
    switch (_currentIndex) {
        case 0:
            // View's Height + (# of post items * 150.0f) + 10 pts of padding
            return self.view.bounds.size.height + (1 * [self getRowHeight] + 10);
            break;
        case 1:
            // View's Height + (# of event items * 150.0f) + 10 pts of padding
            return self.view.bounds.size.height * (3 * [self getRowHeight] + 10);
        default:
            return 0.0f;
    }
}

# pragma mark - getRowHeight

- (CGFloat)getRowHeight {
    switch (_currentIndex) {
        case 0:
            // Return the CLGroupPostCell height
            return 150.0f;
        case 1:
            // Return the CLGroupEventCell height
            return 300.0f;
        default:
            // Default set height to 0.0
            return 0.0f;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
