//
//  CLProfileTableViewController.m
//  Cooleaf
//
//  Created by Haider Khan on 9/3/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import <SDWebImage/UIImageView+WebCache.h>
#import "CLHomeTableViewController.h"
#import "CLProfileTableViewController.h"
#import "CLInformationTableViewcell.h"
#import "CLGroupTableViewCell.h"
#import "CLClient.h"
#import "CLParentTag.h"
#import "CLEventPresenter.h"
#import "UIColor+CustomColors.h"
#import "CLEvent.h"

static NSString *const kScope = @"past";

@interface CLProfileTableViewController() {
    @private
    NSMutableSet *_openSections;
}

@end

@implementation CLProfileTableViewController {
    @private
    CLEventPresenter *_eventPresenter;
    NSMutableArray *_pastEvents;
}

# pragma mark - LifeCycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Initialize XIB file
    [self.tableView registerNib:[UINib nibWithNibName:@"CLInformationTableViewHeader" bundle:nil] forHeaderFooterViewReuseIdentifier:@"informationHeader"];
    
    // Go ahead and init the profile header with the user
    [self initProfileHeaderWithUser:_user];
    
    self.tableView.backgroundColor = [UIColor offWhite];
    self.tableView.rowHeight = [self height];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.segmentedBar addTarget:self action:@selector(segmentChanged) forControlEvents:UIControlEventValueChanged];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    _openSections = [NSMutableSet new];
    [self initEventPresenter];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_eventPresenter unregisterOnBus];
    _eventPresenter.eventInfo = nil;
    _eventPresenter = nil;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

# pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
}

# pragma mark - Initialization Methods

- (void)initEventPresenter {
    _eventPresenter = [[CLEventPresenter alloc] initWithInteractor:self];
    [_eventPresenter registerOnBus];
    NSString *userIdString = [[_user userId] stringValue];
    [_eventPresenter loadUserEvents:kScope userIdString:userIdString];
}

# pragma mark - IEventInteractor Methods

- (void)initEvents:(NSMutableArray *)events {
    
}

- (void)initUserEvents:(NSMutableArray *)userEvents {
    _pastEvents = userEvents;
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
}

# pragma mark - Event Cell Delegate

- (void)didPressJoin:(CLEventCell *)cell {
    
}

- (void)didPressComment:(CLEventCell *)cell {
    
}

# pragma mark - Information Header Delegate

- (void)didPressExpandCollapseButton:(CLInformationTableViewHeader *)header {
    [self.tableView beginUpdates];
    NSUInteger section = header.tag;
    bool isOpen = [_openSections containsObject:@(section)];
    if (isOpen) {
        // Remove it
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:section];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [_openSections removeObject:@(section)];
    }
    else {
        // Add it
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:section];
        [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [_openSections addObject:@(section)];
    }
    [self.tableView endUpdates];
}

# pragma mark - TableView DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Switch statement based on TableView or CollectionView - number of rows
    // Note that Obj C compiler won't work in switch statement without ';' in from of case label
    switch (self.segmentedBar.selectedSegmentIndex) {
        case 0: {
            return [_openSections containsObject:@(section)] ? 1 : 0;
        }
        case 1: {
            return [_pastEvents count];
        }
        case 2:
            // 1 row for collectionview inside cell
            return 1;
        default:
            return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (self.segmentedBar.selectedSegmentIndex) {
        case 0: {
            CLInformationTableViewcell *informationCell = [self.tableView dequeueReusableCellWithIdentifier:@"informationCell" forIndexPath:indexPath];
            informationCell = [self configureInfoCell:informationCell indexPath:indexPath];
            return informationCell;
        }
        case 1: {
            CLEventCell *eventCell = [self.tableView dequeueReusableCellWithIdentifier:@"historyEventCell" forIndexPath:indexPath];
            eventCell.delegate = self;
            
            // Set cell shadow
            eventCell.layer.shadowOpacity = 0.75f;
            eventCell.layer.shadowRadius = 1.0;
            eventCell.layer.shadowOffset = CGSizeMake(0, 0);
            eventCell.layer.shadowColor = [UIColor blackColor].CGColor;
            eventCell.layer.zPosition = 777;
            
            // Get the event
            CLEvent *event = [_pastEvents objectAtIndexedSubscript:[indexPath row]];
            
            // Get the image url
            CLImage *eventImage = [event eventImage];
            NSString *imageUrl = eventImage.url;
            NSString *fullPath = [NSString stringWithFormat:@"%@%@", @"http:", imageUrl];
            fullPath = [fullPath stringByReplacingOccurrencesOfString:@"{{SIZE}}" withString:@"500x200"];
                        
            // Set it into the imageview
            [eventCell.eventImage sd_setImageWithURL:[NSURL URLWithString:fullPath]
                                    placeholderImage:[UIImage imageNamed:nil]];
            
            // Get the event description
            NSString *eventDescription = [event eventDescription];
            eventCell.eventDescription.text = eventDescription;
            
            return eventCell;
        }
        case 2: {
            CLGroupTableViewCell *groupCell = [self.tableView dequeueReusableCellWithIdentifier:@"groupCell" forIndexPath:indexPath];
            groupCell = [self configureGroupCell:groupCell];
            return groupCell;
        }
        default:
            return nil;
    }
}

# pragma mark - TableView Datasource Header

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self getNumOfSections];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    switch (self.segmentedBar.selectedSegmentIndex) {
        case 0:
            return 44.0;
        case 1:
            return 0;
        case 2:
            return 0;
        default:
            return 0;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    switch (self.segmentedBar.selectedSegmentIndex) {
        case 0: {
            CLInformationTableViewHeader *infoHeader = [self.tableView dequeueReusableHeaderFooterViewWithIdentifier:@"informationHeader"];
            infoHeader.tag = section;
            
            infoHeader.delegate = self;
            NSDictionary *userDict = [self getUserDictionary];
            NSString *structureName = [userDict[@"role"][@"organization"][@"structures"] objectAtIndex:section][@"name"];
            infoHeader.infoLabel.text = structureName;
            return infoHeader;
        }
        case 1:
            return nil;
        case 2:
            return nil;
        default:
            return nil;
    }
    
}

# pragma mark - Cell Initialization / Mutator Methods

/**
 *  Initialize the custom information cell with a parent tag
 *
 *  @param infoCell
 *  @param parentTag
 */
- (CLInformationTableViewcell *)configureInfoCell:(CLInformationTableViewcell *)infoCell indexPath:(NSIndexPath *)indexPath {
    NSDictionary *userDict = [self getUserDictionary];
    NSString *structureName = [userDict[@"role"][@"organization"][@"structures"] objectAtIndex:[indexPath row]][@"name"];
    infoCell.tagLabel.text = structureName;
    return infoCell;
}

- (CLEventCell *)configureEventCell:(CLEventCell *)eventCell indexPath:(NSIndexPath *)indexPath {
    if (_pastEvents != nil) {
            }
    return eventCell;
}

/**
 *  Initialize the custom group tableViewCell with the user
 *
 *  @param groupCell
 */
- (CLGroupTableViewCell *)configureGroupCell:(CLGroupTableViewCell *)groupCell {
    if (groupCell == nil) {
        groupCell = [[CLGroupTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"groupCell"];
    }
    groupCell.user = _user;
    return groupCell;
}

# pragma mark - Helper Methods

- (void)segmentChanged {
    self.tableView.rowHeight = [self height];
    [self.tableView reloadData];
}

/**
 *  Switch state for different height variances based on segmented index
 *
 *  @return CGFloat - Height value
 */
- (CGFloat)height {
    switch (self.segmentedBar.selectedSegmentIndex) {
        case 0:
            return self.tableView.rowHeight;
        case 1: {
            return self.tableView.rowHeight = 300;
        }
        case 2:;
            return [CLGroupTableViewCell getHeightForUser:_user];
        default:
            return UITableViewAutomaticDimension;
    }
}

- (NSInteger)getNumOfSections {
    switch (self.segmentedBar.selectedSegmentIndex) {
        case 0: {
            if (_user != nil) {
                NSDictionary *userDict = [self getUserDictionary];
                NSMutableArray *structures = userDict[@"role"][@"organization"][@"structures"];
                return [structures count];
            }
            return 1;
        }
        case 1:
            return 1;
        case 2:;
            return 1;
        default:
            return 1;
    }
}

/**
 *  Get the dictionary value for the CLUser object
 *
 *  @return NSDictionary
 */
- (NSDictionary *)getUserDictionary {
    return [_user dictionaryValue];
}

/**
 *  Init the user in the Header View
 *
 *  @param user
 */
- (void)initProfileHeaderWithUser:(CLUser *)user {
    _userNameLabel.text = [user userName];
    _userRewardsLabel.text = [NSString stringWithFormat:@"%@ %@", @"Reward Points:", [[user rewardPoints] stringValue]];
    
    
    // Get user dictionary
    NSDictionary *userDict = [user dictionaryValue];
    
    // Get credentuals from dictionary
    _userCredentialsLabel.text = userDict[@"role"][@"organization"][@"name"];
    
    // Load user image into blurry background image, and blur it
    
    
    // Load user image into avatar imageview
    NSString *fullImagePath = [NSString stringWithFormat:@"%@%@", [CLClient getBaseApiURL], userDict[@"profile"][@"picture"][@"original"]];
    [_userImage sd_setImageWithURL:[NSURL URLWithString: fullImagePath] placeholderImage:[UIImage imageNamed:@"AvatarPlaceholderMaleMedium"]];
    _userImage.layer.cornerRadius = _userImage.frame.size.width / 2;
    _userImage.clipsToBounds = YES;
}

@end
