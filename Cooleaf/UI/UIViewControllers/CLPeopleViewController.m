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

@interface CLPeopleViewController() {
    @private
    CLUserPresenter *_userPresenter;
    NSMutableArray *_organizationUsers;
}

@end

@implementation CLPeopleViewController

# pragma mark - LifeCycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    [_activityIndicator setHidden:YES];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setupUserPresenter];
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

# pragma mark - setupUserPresenter

- (void)setupUserPresenter {
    _userPresenter = [[CLUserPresenter alloc] initWithInteractor:self];
    [_userPresenter registerOnBus];
    [_userPresenter loadOrganizationUsers];
    [self showActivityIndicator];
}

# pragma mark - IUserInteractor Methods

- (void)initOrganizationUsers:(NSMutableArray *)organizationUsers {
    [self hideActivityIndicator];
    
}

# pragma mark - TableView Data Source Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_organizationUsers count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CLPeopleCell * cell = [tableView dequeueReusableCellWithIdentifier:@"peopleCell"];
    
    cell.peopleLabel.text = @"Prem Bhatia";
    cell.peopleImage.image = [UIImage imageNamed:@"TestImage"];
    cell.positionLabel.text =@"Position";
    
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
