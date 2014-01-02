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

@interface NPEventListViewController ()
{
    NSArray *_events;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UILabel *noEventsLabel;
@property (weak, nonatomic) IBOutlet UILabel *loadingEvents;

- (void)profileTapped:(id)sender;
@end

@implementation NPEventListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Upcoming Events", @"Event list view title");
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ProfileIcon"] style:UIBarButtonItemStylePlain target:self action:@selector(profileTapped:)];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidAppear:(BOOL)animated
{
    [_tableView registerNib:[UINib nibWithNibName:@"NPEventCell" bundle:nil] forCellReuseIdentifier:@"NPEventCell"];
    [_tableView setHidden:YES];
    [_activityIndicator startAnimating];
    _loadingEvents.hidden = NO;
    _noEventsLabel.hidden = YES;
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
        NSLog(@"Fetched %@", events);
    }];
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

- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _events.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NPEventCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NPEventCell"];
    
    cell.event = _events[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [NPEventCell cellHeightForEvent:_events[indexPath.row]];
}

@end
