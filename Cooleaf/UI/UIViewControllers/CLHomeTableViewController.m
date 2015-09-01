//
//  CLHomeTableViewController.m
//  Cooleaf
//
//  Created by Haider Khan on 8/31/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "CLHomeTableViewController.h"

@interface CLHomeTableViewController () {
    @private
    CLEventPresenter *_eventPresenter;
    NSMutableArray *_events;
}

@end

@implementation CLHomeTableViewController


# pragma UIViewController LifeCycle methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Init presenter
    [self initPresenter];
    
    // Load events
    [_eventPresenter loadEvents];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


# pragma IEventInteractor methods

- (void)initEvents:(NSMutableArray *)events {
    // Events receieved here, set into tableview
    
}


# pragma Helper Methods

- (void)initPresenter {
    _eventPresenter = [[CLEventPresenter alloc] initWithInteractor:self];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"eventCell" forIndexPath:indexPath];
    
    
    
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


@end
