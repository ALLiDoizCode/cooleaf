//
//  NPAttendeesViewController.m
//  Cooleaf
//
//  Created by Bazyli Zygan on 07.01.2014.
//  Copyright (c) 2014 Nova Project. All rights reserved.
//

#import "NPAttendeesViewController.h"
#import "NPAttendeeCell.h"
#import "NPCooleafClient.h"

@interface NPAttendeesViewController ()
{
    NSArray *_attendees;
    AFHTTPRequestOperation *_fetchOperation;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation NPAttendeesViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = [NSString stringWithFormat:NSLocalizedString(@"%ld Attendees", nil), _attendeesCount];
    [_tableView registerNib:[UINib nibWithNibName:@"NPAttendeeCell" bundle:nil] forCellReuseIdentifier:@"NPAttendeeCell"];

    [_activityIndicator startAnimating];
    _fetchOperation = [[NPCooleafClient sharedClient] fetchParticipantsForEventWithId:_eventId completion:^(NSArray *participants) {
        _fetchOperation = nil;
        [_activityIndicator stopAnimating];
        _attendees = participants;
        [_tableView reloadData];
        _tableView.hidden = NO;
    }];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    if (_fetchOperation)
    {
        [_fetchOperation cancel];
        _fetchOperation = nil;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return (NSInteger)_attendees.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NPAttendeeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NPAttendeeCell"];
    
    cell.attendee = _attendees[indexPath.row];
    
    return cell;
}

@end
