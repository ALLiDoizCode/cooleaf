//
//  CLGroupEventsController.m
//  Cooleaf
//
//  Created by Jonathan Green on 9/24/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "CLGroupEventsController.h"
#import "CLGroupEventCell.h"

@interface CLGroupEventsController ()

@end

@implementation CLGroupEventsController

# pragma mark - LifeCycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma mark - TableView DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CLGroupEventCell *cell = [tableView dequeueReusableCellWithIdentifier:@"groupEvent"];
    
    cell.eventTitleLabel.text = @"Marathon of the Century";
    cell.dateLabel.text = @"July 1,2015";
    cell.rewardsLabel.text = @"50 Reward Points";
    cell.eventDescription.text = @"Prepare yourself for the Marathon of the Century and the picnic afterwoods!";
    cell.commentLabel.text = @"4 comments";
    cell.participansLabel.text = @"5 participants";
    
    return cell;
}

# pragma mark - TableView Delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
