//
//  CLPeopleViewController.m
//  Cooleaf
//
//  Created by Jonathan Green on 9/10/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import <SDWebImage/UIImageView+WebCache.h>
#import "UIColor+CustomColors.h"
#import "CLPeopleViewController.h"
#import "CLPeopleCell.h"
#import "CLUserPresenter.h"
#import "CLUser.h"
#import "CLClient.h"
#import "CLInterestPresenter.h"
#import "CLParticipantPresenter.h"

@interface CLPeopleViewController() {
    @private
    CLUserPresenter *_userPresenter;
    CLParticipantPresenter *_participantPresenter;
    CLInterestPresenter *_interestPresenter;
    NSMutableArray *_organizationUsers;
    NSMutableArray *_members;
    NSMutableArray *_participants;
    UIColor *_barColor;
}

@end

@implementation CLPeopleViewController

# pragma mark - LifeCycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    [_activityIndicator setHidden:YES];
    [self setupNavBar];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (_currentView == nil) {
        [self setupUserPresenter];
    } else {
        if ([_currentView isEqualToString:@"Events"])
            [self setupParticipantPresenter];
            
        if ([_currentView isEqualToString:@"Groups"])
            [self setupInterestPresenter];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (_userPresenter)
        [_userPresenter unregisterOnBus];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma mark - setupNavBar

- (void)setupNavBar {
    self.navigationController.navigationBar.topItem.title = @"People";
    self.navigationController.navigationBar.alpha = 1;
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:UITextAttributeTextColor];
    _barColor = [UIColor colorPrimary];
    self.navigationController.navigationBar.barTintColor = _barColor;
}

# pragma mark - setupUserPresenter

- (void)setupUserPresenter {
    _userPresenter = [[CLUserPresenter alloc] initWithInteractor:self];
    [_userPresenter registerOnBus];
    [_userPresenter loadOrganizationUsers];
    [self showActivityIndicator];
}

# pragma mark - setupParticipantPresenter

- (void)setupParticipantPresenter {
    _participantPresenter = [[CLParticipantPresenter alloc] initWithInteractor:self];
    [_participantPresenter registerOnBus];
    [_participantPresenter loadEventParticipants:[[_event eventId] integerValue]];
    [self showActivityIndicator];
}

# pragma mark - setupInterestPresenter

- (void)setupInterestPresenter {
    _interestPresenter = [[CLInterestPresenter alloc] initWithDetailInteractor:self];
    [_interestPresenter registerOnBus];
    [_interestPresenter loadInterestMembers:[[_interest interestId] integerValue]];
    [self showActivityIndicator];
}

# pragma mark - IUserInteractor Methods

- (void)initOrganizationUsers:(NSMutableArray *)organizationUsers {
    [self hideActivityIndicator];
    _organizationUsers = organizationUsers;
    [_tableView reloadData];
}

# pragma mark - IParticipantInteractor Methods

- (void)initParticipants:(NSMutableArray *)participants {
    [self hideActivityIndicator];
    _participants = participants;
    [_tableView reloadData];
}

# pragma mark - IInterestDetailInteractor Methods

- (void)initMembers:(NSMutableArray *)members {
    [self hideActivityIndicator];
    _members = members;
    [_tableView reloadData];
}

# pragma mark - TableView Data Source Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Check to see where people view controller was instantiated from get correct count
    if (_currentView == nil)
        return [_organizationUsers count];
    else if ([_currentView isEqualToString:@"Events"])
        return [_participants count];
    else
        return [_members count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CLPeopleCell * cell = [tableView dequeueReusableCellWithIdentifier:@"peopleCell"];
    
    if ([_currentView isEqualToString:@"Groups"]) {
        
        // Get the participant dictionary
        NSDictionary *participantDict = [_members objectAtIndex:[indexPath row]];
        
        // Set the name
        cell.peopleLabel.text = participantDict[@"name"];
        
        // Set the position label
        cell.positionLabel.text = @"";
        
        // Set the image
        NSString *path = participantDict[@"profile"][@"picture"][@"versions"][@"icon"];
        NSString *fullImagePath = [NSString stringWithFormat:@"%@%@", [CLClient getBaseApiURL], path];
        [cell.peopleImage sd_setImageWithURL:[NSURL URLWithString: fullImagePath] placeholderImage:[UIImage imageNamed:@"AvatarPlaceholderMaleMedium"]];
        
    } else if ([_currentView isEqualToString:@"Events"]) {
        
        // Get the participant dictionary
        NSDictionary *participantDict = [_participants objectAtIndex:[indexPath row]];
        
        // Set the name
        cell.peopleLabel.text = participantDict[@"name"];
        
        // Get a tag at index 0 of structure_tags array and set it
        NSString *tagName = [participantDict[@"role"][@"structure_tags"] objectAtIndex:0][@"name"];
        cell.positionLabel.text = tagName;
        
        // Set the image
        NSString *path = participantDict[@"profile"][@"picture"][@"versions"][@"icon"];
        NSString *fullImagePath = [NSString stringWithFormat:@"%@%@", [CLClient getBaseApiURL], path];
        [cell.peopleImage sd_setImageWithURL:[NSURL URLWithString: fullImagePath] placeholderImage:[UIImage imageNamed:@"AvatarPlaceholderMaleMedium"]];
        
    } else {
        
        // Get the user object
        CLUser *user = [_organizationUsers objectAtIndex:[indexPath row]];
        
        // Get the user dictionary
        NSDictionary *userDict = [user dictionaryValue];
        
        cell.peopleLabel.text = [user userName];
        cell.positionLabel.text = userDict[@"role"][@"department"][@"name"];
        
        // Load user image into avatar imageview
        NSString *path = userDict[@"profile"][@"picture"][@"versions"][@"icon"];
        NSString *fullImagePath = [NSString stringWithFormat:@"%@%@", [CLClient getBaseApiURL], path];
        [cell.peopleImage sd_setImageWithURL:[NSURL URLWithString: fullImagePath] placeholderImage:[UIImage imageNamed:@"AvatarPlaceholderMaleMedium"]];
    }
    
    return cell;
}

# pragma mark - TableView Delegate Methods

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

# pragma mark - showActivityIndicator

- (void)showActivityIndicator {
    [_activityIndicator setHidden:NO];
    [_activityIndicator setColor:[UIColor colorAccent]];
    [_activityIndicator startAnimating];
}

# pragma mark - hideActivityIndicator

- (void)hideActivityIndicator {
    [_activityIndicator stopAnimating];
    [_activityIndicator setHidden:YES];
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
