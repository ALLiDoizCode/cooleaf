//
//  NPInterestViewController.m
//  Cooleaf
//
//  Created by Dirk R on 3/15/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "NPInterestViewController.h"
#import "NPCooleafClient.h"
#import "NPAttendeesViewController.h"
#import "NPEventListViewController.h"
#import "NPMembersViewController.h"

// Cells
#import "NPAttendeesCell.h"
#import "NPMembersCell.h"
#import "NPGroupEventsCell.h"


enum {
	NPEventCell_Attendees = 0,
	NPEventCell_GroupEvents,
	NPEventCell_Date,
	NPEventCell_Location,
	NPEventCell_Details,
	NPEventCell_Todos,
	
	NPEventCell_Count
};


@interface NPInterestViewController ()
{
	AFHTTPRequestOperation *_fetchingOperation;
	NSDictionary *_currentEvent;
	CGFloat _shift;
}

@property (strong, nonatomic) IBOutlet UIView *eventChangeButtons;
@property (weak, nonatomic) IBOutlet UIButton *prevEventButton;
@property (weak, nonatomic) IBOutlet UIButton *nextEventButton;
@property (weak, nonatomic) IBOutlet UIButton *resignButton;

@property (strong, nonatomic) IBOutlet UIView *tableHeaderView;
@property (weak, nonatomic) IBOutlet UIButton *joinButton;
@property (weak, nonatomic) IBOutlet UITextView *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *coverPhotoView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextView *categoriesLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingIndicator;
@property (weak, nonatomic) IBOutlet UIView *backgroundView;

- (void)setEvent:(NSDictionary *)event;
- (IBAction)joinTapped:(id)sender;

- (IBAction)switchEventTapped:(UIButton *)sender;
- (IBAction)resignTapped:(id)sender;

- (void)updateJoinButton;
- (void)updateCells;
- (void)notificationReceived:(NSNotification *)not;

@end

@implementation NPInterestViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
		self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]
												 initWithTitle:NSLocalizedString(@"Group", nil)
												 style:UIBarButtonItemStylePlain
												 target:nil
												 action:nil];
	}
	return self;
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	// Register cell types
	[_tableView registerNib:[UINib nibWithNibName:@"NPMembersCell" bundle:nil] forCellReuseIdentifier:@"NPMembersCell"];
	[_tableView registerNib:[UINib nibWithNibName:@"NPGroupEventsCell" bundle:nil] forCellReuseIdentifier:@"NPGroupEventsCell"];
	[_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"NPDefaultCell"];
//	[_tableView registerNib:[UINib nibWithNibName:@"NPDateCell" bundle:nil] forCellReuseIdentifier:@"NPDateCell"];
//	[_tableView registerNib:[UINib nibWithNibName:@"NPLocationCell" bundle:nil] forCellReuseIdentifier:@"NPLocationCell"];
//	[_tableView registerNib:[UINib nibWithNibName:@"NPDetailsCell" bundle:nil] forCellReuseIdentifier:@"NPDetailsCell"];
//	[_tableView registerNib:[UINib nibWithNibName:@"NPTodosCell" bundle:nil] forCellReuseIdentifier:@"NPTodosCell"];
	
	_tableView.tableHeaderView = _tableHeaderView;
	//    [self setEvent:_events[_eventIdx]];
	

	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_eventChangeButtons];
	
	_prevEventButton.enabled = (_eventIdx != 0);
	_nextEventButton.enabled = (_eventIdx < _events.count-1);
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationReceived:) name:kNPCooleafClientRefreshNotification object:nil];
}

- (void)notificationReceived:(NSNotification *)not
{
	[self setEvent:_events[_eventIdx]];
}

- (void)viewWillAppear:(BOOL)animated
{
	[self setEvent:_events[_eventIdx]];
}

- (void)setEvent:(NSDictionary *)event
{
	
	CGRect f;
	CGFloat shift = 0;
	
	if (_fetchingOperation)
	{
		[_fetchingOperation cancel];
		_fetchingOperation = nil;
	}
	_currentEvent = nil;
	_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	[_tableView reloadData];
	
	
	//    // Button border
	//    _joinButton.layer.borderWidth = 1;
	//    _joinButton.layer.borderColor = _joinButton.titleLabel.textColor.CGColor;
	//    _joinButton.layer.cornerRadius = 2.0;
	//
	// Set cover image
	DLog(@"%@", event);
	if (event[@"image"][@"url"] != nil) {
		NSString *imageUrlString = [@"http:" stringByAppendingString:[event[@"image"][@"url"] stringByReplacingOccurrencesOfString:@"{{SIZE}}" withString:@"640x150"]];
		// Download image for event
		[[NPCooleafClient sharedClient] fetchImage:imageUrlString completion:^(NSString *imagePath, UIImage *image) {
			if ([imagePath compare:imageUrlString] == NSOrderedSame)
			{
				_coverPhotoView.image = image;
			}
		}];
	}
	// Calculate size for title
	_titleLabel.text = event[@"name"];
	f = _titleLabel.frame;
	[_titleLabel sizeToFit];
	_titleLabel.frame = CGRectMake(f.origin.x, f.origin.y, f.size.width, _titleLabel.frame.size.height);
	//    shift = _titleLabel.frame.size.height - 10;
	
//	// Calculate size for hashes
//	NSMutableString *hashes = [NSMutableString string];
//	for (NSString *hash in event[@"slug"])
//	{
//		if (hashes.length > 0)
//			[hashes appendFormat:@" #%@", hash];
//		else
//			[hashes appendFormat:@"#%@", hash];
//	}
//	
//	_categoriesLabel.text = [hashes uppercaseString];
	f = _categoriesLabel.frame;
	[_categoriesLabel sizeToFit];
	_categoriesLabel.frame = CGRectMake(f.origin.x, 45 + shift, f.size.width, _categoriesLabel.frame.size.height);
	//    shift += _categoriesLabel.frame.size.height;
	
	// Move necessary elements down
	_joinButton.transform = CGAffineTransformMakeTranslation(0, shift);
	//    _rewardLabel.transform = CGAffineTransformMakeTranslation(0, shift);
	_loadingIndicator.transform = CGAffineTransformMakeTranslation(0, shift);
	_resignButton.transform = CGAffineTransformMakeTranslation(0, shift);
	_shift = shift;
	// Assign global information
	
	// Resize header
	f = _tableHeaderView.frame;
	f.size.height = 245;
	_tableHeaderView.frame = f;
	f = _backgroundView.frame;
	f.size.height = 245;
	_backgroundView.frame = f;
	
	// Reassign header again
	_tableView.tableHeaderView = _tableHeaderView;
	
	// Time to hide buttons and download details
	_joinButton.hidden = YES;
	_resignButton.hidden = YES;
	[_loadingIndicator startAnimating];
	_fetchingOperation = [[NPCooleafClient sharedClient] fetchGroupWithId:event[@"id"] completion:^(NSDictionary *eventDetails) {
		[_loadingIndicator stopAnimating];
		_fetchingOperation = nil;
		
		if (eventDetails)
		{
			_currentEvent = eventDetails;
		}
		
		// Update button
		[self updateJoinButton];
		
		// And build cells
		[self updateCells];
		
	}];
	
}


- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (void)updateJoinButton
{
	//	_joinButton.layer.borderColor = [[_joinButton titleColorForState:(([_currentEvent[@"attending"] boolValue]) ? UIControlStateDisabled : UIControlStateNormal)] CGColor];
	//	_resignButton.layer.borderColor = [[_resignButton titleColorForState:((![_currentEvent[@"attending"] boolValue]) ? UIControlStateDisabled : UIControlStateNormal)] CGColor];
	DLog(@" The Current event Value is %@", _currentEvent);
	_joinButton.enabled = ![_currentEvent[@"member"] boolValue];
	_resignButton.hidden = ![_currentEvent[@"member"] boolValue];
	_joinButton.hidden = [_currentEvent[@"member"] boolValue];
	
	if ([_currentEvent[@"member"] boolValue])
	{
		_joinButton.frame = CGRectMake(280, 203, 32, 32);
		_resignButton.frame = CGRectMake(280, 203, 32, 32);
		DLog(@"Joing button should be on");
	}
	else
	{
		_joinButton.frame = CGRectMake(280, 203, 32, 32);
		_resignButton.frame = CGRectMake(280, 203, 32, 32);
		DLog(@"Leave button should be on");

	}
	//    _joinButton.transform = CGAffineTransformMakeTranslation(0, _shift);
}

- (void)updateCells
{
	_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	[_tableView reloadData];
}

- (IBAction)joinTapped:(id)sender
{
	_joinButton.hidden = YES;
	_resignButton.hidden = YES;
	[_loadingIndicator startAnimating];
	_fetchingOperation = [[NPCooleafClient sharedClient] joinGroupWithId:_currentEvent[@"id"] completion:^(NSError *error) {
		_fetchingOperation = [[NPCooleafClient sharedClient] fetchGroupWithId:_currentEvent[@"id"] completion:^(NSDictionary *eventDetails) {
			[_loadingIndicator stopAnimating];
			_fetchingOperation = nil;
			_currentEvent = eventDetails;
			// Update button
			[self updateJoinButton];
			
			// And build cells
			[self updateCells];
			
		}];
	}];
}

- (IBAction)switchEventTapped:(UIButton *)sender
{
	if (sender == _prevEventButton)
	{
		_eventIdx--;
	}
	else
	{
		_eventIdx++;
	}
	_prevEventButton.enabled = (_eventIdx != 0);
	_nextEventButton.enabled = (_eventIdx < _events.count-1);
	
	[self setEvent:_events[_eventIdx]];
}

- (IBAction)resignTapped:(id)sender
{
	UIActionSheet *as = [[UIActionSheet alloc] initWithTitle:NSLocalizedString(@"Do you really want to unregister?", nil)
													delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", nil)
									  destructiveButtonTitle:NSLocalizedString(@"Yes, I want to unregister", nil) otherButtonTitles:nil];
	
	[as showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
	if (buttonIndex == 0)
	{
		// We should resign, so
		_joinButton.hidden = YES;
		_resignButton.hidden = YES;
		[_loadingIndicator startAnimating];
		_fetchingOperation = [[NPCooleafClient sharedClient] leaveGroupWithId:_currentEvent[@"id"] completion:^(NSError *error) {
			_fetchingOperation = [[NPCooleafClient sharedClient] fetchGroupWithId:_currentEvent[@"id"] completion:^(NSDictionary *eventDetails) {
				[_loadingIndicator stopAnimating];
				_fetchingOperation = nil;
				_currentEvent = eventDetails;
				// Update button
				[self updateJoinButton];
				
				// And build cells
				[self updateCells];
				
			}];
		}];
	}
}

#pragma mark - UITableView stuff

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return (_currentEvent) ? NPEventCell_Count : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	switch (indexPath.row) {
		case NPEventCell_Attendees:
		{
			NPMembersCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NPMembersCell"];
			cell.selfAttended = [_currentEvent[@"member"] boolValue];
			
			cell.attendeesCount = [_currentEvent[@"users_count"] unsignedIntegerValue];
//			cell.attendees = _currentEvent[@"participants"];
			[[NPCooleafClient sharedClient] fetchMembersForGroupWithId:_currentEvent[@"id"] completion:^(NSArray *members) {
				DLog(@"%@", members);
				cell.attendees = members;
			}];
			return cell;
			
		}
			break;
			
		case NPEventCell_GroupEvents:
		{
			NPGroupEventsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NPGroupEventsCell"];
			cell.groupID = _currentEvent[@"id"];
			return cell;
		}
			
			//		case NPEventCell_Date:
			//		{
			//			NPDateCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NPDateCell"];
			//			cell.dateString = _currentEvent[@"start_time"];
			//			cell.title = _currentEvent[@"name"];
			//			return cell;
			//		}
			//			break;
			//
			//		case NPEventCell_Location:
			//		{
			//			NPLocationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NPLocationCell"];
			//			cell.address = _currentEvent[@"address"];
			//			return cell;
			//		}
			//			break;
			//
			//		case NPEventCell_Details:
			//		{
			//			NPDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NPDetailsCell"];
			//			cell.detailsText = _currentEvent[@"description"];
			//			return cell;
			//		}
			//			break;
			//
			//		case NPEventCell_Todos:
			//		{
			//			NPTodosCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NPTodosCell"];
			//			// Find appropriate widget
			//			for (NSDictionary *widget in _currentEvent[@"widgets"])
			//			{
			//				if ([widget[@"type"] isEqualToString:@"todo"])
			//				{
			//					cell.todosCount = [widget[@"propositions"] count];
			//					break;
			//				}
			//			}
			//			return cell;
			//		}
			//			break;
		default:
			return [tableView dequeueReusableCellWithIdentifier:@"NPDefaultCell"];
	}
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	switch (indexPath.row) {
		case NPEventCell_Attendees:
			if ([_currentEvent[@"users_count"] integerValue] > 0)
				return 44.0;
			else
				return 44.0;
		case NPEventCell_GroupEvents:
			return 60;
			//		case NPEventCell_Date:
			//			return 94.0;

			//
			//		case NPEventCell_Location:
			//			if (_currentEvent[@"address"][@"lat"])
			//				return 176;
			//			else
			//				return 94.0;
			//			break;
			//
			//		case NPEventCell_Todos:
			//			return 53.0;
			//			break;
			//
			//		case NPEventCell_Details:
			//			return [NPDetailsCell cellHeightForText:_currentEvent[@"description"]];
			//			break;
		default:
			return 44;
	}
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
	switch (indexPath.row) {
		case NPEventCell_Attendees:
			if ([_currentEvent[@"users_count"] integerValue] > 0)
				return YES;
			else
				return NO;
		default:
			return YES;
	}
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[_tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	switch (indexPath.row) {
			//		case NPEventCell_Todos:
			//		{
			//			NPTodoViewController *tC = [NPTodoViewController new];
			//			tC.event = _currentEvent;
			//			[self.navigationController pushViewController:tC animated:YES];
			//		}
//			break;
		case NPEventCell_Attendees:
		{
			NPMembersViewController *aV = [NPMembersViewController new];
			aV.eventId = _currentEvent[@"id"];
			aV.attendeesCount = [_currentEvent[@"users_count"] integerValue];
			[self.navigationController pushViewController:aV animated:YES];
		}
			break;
		case NPEventCell_GroupEvents:
		{
			NPEventListViewController *groupEventListController = [NPEventListViewController new];
			groupEventListController.title = @"Group Events";
			DLog(@"selected the groups row");
			[self.navigationController pushViewController:groupEventListController animated:YES];
		}
			break;
		default:
			break;
	}
}
@end
