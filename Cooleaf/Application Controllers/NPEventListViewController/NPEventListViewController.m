//
//  NPEventListViewController.m
//  Cooleaf
//
//  Created by Bazyli Zygan on 14.12.2013.
//  Copyright (c) 2013 Nova Project. All rights reserved.
//

#import "NPEventListViewController.h"
#import "NPCooleafClient.h"
#import "NPEventCell.h"
#import "NPProfileViewController.h"
#import "NPEventViewController.h"

@interface NPEventListViewController ()
{
    NSArray *_events;
    NSMutableDictionary *_joinActions;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UILabel *noEventsLabel;
@property (weak, nonatomic) IBOutlet UILabel *loadingEvents;

- (void)profileTapped:(id)sender;
- (void)notificationReceived:(NSNotification *)not;

@end

@implementation NPEventListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Upcoming Events", @"Event list view title");
//        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Profile"] style:UIBarButtonItemStylePlain target:self action:@selector(profileTapped:)];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"Profile"] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(profileTapped:) forControlEvents:UIControlEventTouchUpInside];
        btn.frame = CGRectMake(0, 0, 30, 30);
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]
                                                 initWithTitle:NSLocalizedString(@"Upcoming", @"Event list view title")
                                                 style:UIBarButtonItemStylePlain
                                                 target:nil
                                                 action:nil];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _joinActions = [NSMutableDictionary new];
    [_tableView registerNib:[UINib nibWithNibName:@"NPEventCell" bundle:nil] forCellReuseIdentifier:@"NPEventCell"];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationReceived:) name:kNPCooleafClientRefreshNotification object:nil];
}

- (void)notificationReceived:(NSNotification *)not
{
    [self reloadEvents];
}

- (void)reloadEvents
{
    [[NPCooleafClient sharedClient] fetchEventList:^(NSArray *events) {
        [_activityIndicator stopAnimating];
        _loadingEvents.hidden = YES;
        _events = events;
        if (_events.count > 0)
        {
            [_tableView setHidden:NO];
            [_tableView reloadData];
        }
        else
        {
            _noEventsLabel.hidden = NO;
        }
    }];
}

- (void)viewDidAppear:(BOOL)animated
{
    if (!_events)
    {
        [_tableView setHidden:YES];
        [_activityIndicator startAnimating];
        _loadingEvents.hidden = NO;
        _noEventsLabel.hidden = YES;
    }
    [self reloadEvents];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)profileTapped:(id)sender
{
    [self.navigationController pushViewController:[NPProfileViewController new] animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _events.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NPEventCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NPEventCell"];
    
    cell.event = _events[indexPath.row];
    cell.loading = (_joinActions[_events[indexPath.row][@"id"]] != nil);
    if (!cell.actionTapped)
    {
        cell.actionTapped = ^(NSNumber *eventId, BOOL join) {
            if (!_joinActions[eventId])
            {
                if (join)
                {
                    _joinActions[eventId] = [[NPCooleafClient sharedClient] joinEventWithId:eventId completion:^(NSError *error) {
                        [_joinActions removeObjectForKey:eventId];
                        NPEventCell *c = (NPEventCell *)[tableView cellForRowAtIndexPath:indexPath];
                        if (c)
                            [c closeDrawer];
                        
                        
                        [self reloadEvents];
                    }];
                }
                else
                {
                    _joinActions[eventId] = [[NPCooleafClient sharedClient] leaveEventWithId:eventId completion:^(NSError *error) {
                        [_joinActions removeObjectForKey:eventId];
                        NPEventCell *c = (NPEventCell *)[tableView cellForRowAtIndexPath:indexPath];
                        if (c)
                            [c closeDrawer];
                        
                        [self reloadEvents];
                    }];
                }
                return YES;
            }
            return NO;
        };
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [NPEventCell cellHeightForEvent:_events[indexPath.row]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NPEventViewController *eC = [NPEventViewController new];
    eC.events = _events;
    eC.eventIdx = indexPath.row;
    
    [self.navigationController pushViewController:eC animated:YES];
}



@end
