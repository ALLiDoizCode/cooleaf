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
    CLAuthenticationPresenter *_authPres;
    CLEventPresenter *_eventPresenter;
    NSMutableArray *_events;
}

@end

@implementation CLHomeTableViewController


# pragma UIViewController LifeCycle methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Init pull to refresh
    [self initPullToRefresh];
    
    // Init auth presenter
    _authPres = [[CLAuthenticationPresenter alloc] initWithInteractor:self];
    [_authPres registerOnBus];
    [_authPres authenticate:@"kevin.coleman@sparkstart.io" :@"passwordpassword"];
    
    // Init event presenter
    [self initPresenter];
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


# pragma IAuthenticationInteractor methods

- (void)initUser:(CLUser *)user {
    // Load events
    [_eventPresenter loadEvents];
}


# pragma IEventInteractor methods

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


# pragma Helper Methods

- (void)initPresenter {
    _eventPresenter = [[CLEventPresenter alloc] initWithInteractor:self];
    [_eventPresenter registerOnBus];
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
    return [_events count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"eventCell" forIndexPath:indexPath];
    
    // Get the event
    CLEvent *event = [_events objectAtIndex:[indexPath row]];
    
    // Get the image url
    NSString *eventDescription = [event eventDescription];
    
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


# pragma Helper Methods

- (void)initPullToRefresh {
    self.refreshControl = [[UIRefreshControl alloc] init];
    self.refreshControl.backgroundColor = [UIColor colorAccent];
    self.refreshControl.tintColor = [UIColor whiteColor];
    [self.refreshControl addTarget:self
                            action:@selector(reloadEvents)
                  forControlEvents:UIControlEventValueChanged];
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
