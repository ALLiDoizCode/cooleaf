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

@interface CLGroupDetailViewController()

@property (assign) int currentIndex;
@property (nonatomic) CLInterestPresenter *interestPresenter;
@property (nonatomic) UIColor *barColor;
@property (nonatomic) NSMutableArray *posts;
@property (nonatomic) NSMutableArray *events;
@property (nonatomic) NSMutableArray *members;

@end

@implementation CLGroupDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupSearch];
    [self setupTableView];
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setupInterestPresenter];
    [self grabColor];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
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

-(void)grabColor {
    
    // Get four dominant colors from the image, but avoid the background color of our UI
    CCColorCube *colorCube = [[CCColorCube alloc] init];
    UIImage *img =_detailView.mainImageView.image;
    NSArray *imgColors = [colorCube extractColorsFromImage:img flags:nil];
    _barColor = imgColors[1];
    
    self.navigationController.navigationBar.barTintColor = _barColor;
    self.navigationController.navigationBar.alpha = 0.7;
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:UITextAttributeTextColor];
}

#pragma mark - searchDisplay

-(void)setupSearch {
    
    // Set text on navbar to white
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:UITextAttributeTextColor];
    
    // Set nav bar color
    _barColor = [UIColor searchNavBarColor];
    self.navigationController.navigationBar.barTintColor = _barColor;
    
    // Set buttons
    UIBarButtonItem *searchBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:nil];
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
    [_detailView.mainImageView sd_setImageWithURL:[NSURL URLWithString:self.currentImagePath]
                                 placeholderImage:[UIImage imageNamed:nil]];
    
    // Load name for group
    _detailView.labelName.text =[NSString stringWithFormat: @"#%@", _currentName];
    
    // Add number of participants
    [_detailView.members setTitle:[NSString stringWithFormat:@"%d Members >", [[_interest userCount] intValue]]
                         forState:UIControlStateNormal];
}

# pragma mark - setupGroupPresenter

- (void)setupInterestPresenter {
    _interestPresenter = [[CLInterestPresenter alloc] initWithDetailInteractor:self];
    [_interestPresenter registerOnBus];
    
    // Make a call to grab members
    [_interestPresenter loadInterestMembers:[[_interest interestId] intValue]];
}

# pragma mark - CLDetailViewDelegate

- (void)selectSegment:(CLDetailView *)detailView {
    _currentIndex = (int) detailView.segmentedControl.selectedSegmentIndex;
    switch (_currentIndex) {
        case 0: {
            // User selected posts, set row height and reload data
            [_detailScroll setContentSize:CGSizeMake(_detailScroll.contentSize.width, [self getScrollViewHeight])];
            [self.tableView setRowHeight:[self getRowHeight]];
            [self.tableView reloadData];
            break;
        }
        case 1: {
            // User selected events
            [_detailScroll setContentSize:CGSizeMake(_detailScroll.contentSize.width, [self getScrollViewHeight])];
            [self.tableView setRowHeight:[self getRowHeight]];
            [self.tableView reloadData];
        }
        default:
            break;
    }
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


# pragma mark - TableView Data Source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return posts count if user selects posts segment, or events count if user selects events segment
    switch (_currentIndex) {
        case 0:
            return [_posts count];
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
