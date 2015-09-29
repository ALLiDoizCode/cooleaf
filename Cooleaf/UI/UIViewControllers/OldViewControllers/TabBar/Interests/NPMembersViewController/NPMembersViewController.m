//
//  NPMembersViewController.m
//  Cooleaf
//
//  Created by Dirk R on 3/28/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "NPMembersViewController.h"
#import "NPMemberCell.h"
#import "NPCooleafClient.h"


@interface NPMembersViewController ()
{
	NSArray *_attendees;
	AFHTTPRequestOperation *_fetchOperation;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation NPMembersViewController

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
	if (_attendeesCount > 1)
		self.title = [NSString stringWithFormat:NSLocalizedString(@"%ld Members", nil), _attendeesCount];
	else
		self.title = [NSString stringWithFormat:NSLocalizedString(@"%ld Member", nil), _attendeesCount];
	[_tableView registerNib:[UINib nibWithNibName:@"NPMemberCell" bundle:nil] forCellReuseIdentifier:@"NPMemberCell"];
	
	[_activityIndicator startAnimating];
	_fetchOperation = [[NPCooleafClient sharedClient] fetchMembersForGroupWithId:_eventId completion:^(NSArray *participants) {
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
	NPMemberCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NPMemberCell"];
	
	cell.attendee = _attendees[indexPath.row];
	
	return cell;
}

@end
