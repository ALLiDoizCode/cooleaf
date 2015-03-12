//
//  NPInterestsViewController.m
//  Cooleaf
//
//  Created by Dirk R on 2/28/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "NPInterestsViewController.h"
#import "NPCooleafClient.h"
#import "NPInterestCell.h"
#import "NPOtherInterestCell.h"
#import "NPProfileViewController.h"
#import "NPEventViewController.h"

@interface NPInterestsViewController ()
{
	NSArray *_myEvents;
	NSArray *_otherEvents;
	NSMutableDictionary *_joinActions;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UILabel *noEventsLabel;
@property (weak, nonatomic) IBOutlet UILabel *loadingEvents;
@property (strong, nonatomic) IBOutlet UIView *otherBranchesHeader;

//- (void)profileTapped:(id)sender;
- (void)notificationReceived:(NSNotification *)not;
- (void)signedOut:(NSNotification *)not;

@end

@implementation NPInterestsViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self) {
		self.title = NSLocalizedString(@"Groups", @"Groups list view title");
		//        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Profile"] style:UIBarButtonItemStylePlain target:self action:@selector(profileTapped:)];
//		UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//		[btn setImage:[UIImage imageNamed:@"Profile"] forState:UIControlStateNormal];
//		[btn addTarget:self action:@selector(profileTapped:) forControlEvents:UIControlEventTouchUpInside];
//		btn.frame = CGRectMake(0, 0, 30, 30);
//		self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
		self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]
												 initWithTitle:NSLocalizedString(@"Groups", @"Groups list view title")
												 style:UIBarButtonItemStylePlain
												 target:nil
												 action:nil];
		
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(signedOut:) name:kNPCooleafClientSignOut object:nil];
		[[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:78.0/255.0 green:205.0/255.0 blue:196.0/255.0 alpha:1.0]];
		[[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
		[[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys: [UIColor whiteColor], NSForegroundColorAttributeName, nil]];
		
		
	}
	return self;
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	_joinActions = [NSMutableDictionary new];
	UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 15)];
	UIView *footerSep = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 0.5)];
	footer.backgroundColor = self.view.backgroundColor;
	footerSep.backgroundColor = [UIColor colorWithRed:209.0/255.0 green:208.0/255.0 blue:213.0/255.0 alpha:1];
	[footer addSubview:footerSep];
	_tableView.tableFooterView = footer;
	
	[_tableView registerNib:[UINib nibWithNibName:@"NPInterestCell" bundle:nil] forCellReuseIdentifier:@"NPInterestCell"];
	[_tableView registerNib:[UINib nibWithNibName:@"NPOtherInterestCell" bundle:nil] forCellReuseIdentifier:@"NPOtherInterestCell"];
	[_tableView registerNib:[UINib nibWithNibName:@"NPInterestTopCell" bundle:nil] forCellReuseIdentifier:@"NPInterestTopCell"];
	_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationReceived:) name:kNPCooleafClientRefreshNotification object:nil];
}

- (void)notificationReceived:(NSNotification *)not
{
	[self reloadEvents];
}

- (void)signedOut:(NSNotification *)not
{
	_myEvents = nil;
	_otherEvents = nil;
	[_tableView setHidden:YES];
	[_activityIndicator startAnimating];
	_loadingEvents.hidden = NO;
	_noEventsLabel.hidden = YES;
}

- (void)reloadEvents
{
	[[NPCooleafClient sharedClient] fetchInterestList:^(NSArray *events) {
		[_activityIndicator stopAnimating];
		_loadingEvents.hidden = YES;
		NSMutableArray *myEvents = [NSMutableArray new];
		NSMutableArray *otherEvents = [NSMutableArray new];

		NSNumber *myBranch = [NPCooleafClient sharedClient].userData[@"role"][@"branch"][@"id"];
		for (NSDictionary *e in events)
		{
			BOOL my = NO;
			if ([e[@"branches"] count] == 0)
				my = YES;
			else
			{
				for (NSDictionary *branch in e[@"branches"])
				{
					if ([branch[@"id"] isEqualToNumber:myBranch])
					{
						my = YES;
						break;
					}
				}
			}
			
			if (my)
				[myEvents addObject:e];
			else
				[otherEvents addObject:e];
		}
		
		_myEvents = myEvents;
		_otherEvents = otherEvents;
		NSLog(@"%@",otherEvents);

		if (events.count > 0)
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
	if (_myEvents.count == 0 && _otherEvents.count == 0)
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



- (UITabBarItem *)tabBarItem
{
	return [[UITabBarItem alloc] initWithTitle:self.title
										 image:[[UIImage imageNamed:@"Interests"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
								 selectedImage:[UIImage imageNamed:@"Interests"]];
}



//- (void)profileTapped:(id)sender
//{
//	[self.navigationController pushViewController:[NPProfileViewController new] animated:YES];
//}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	if (_otherEvents.count > 0)
		return _myEvents.count + _otherEvents.count + 2;
	else if (_myEvents.count > 0)
		return _myEvents.count + 1;
	else
		return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForMyEventAtIndex:(NSInteger)row
{
	NPInterestCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NPInterestCell"];
	
	cell.event = _myEvents[row];
	cell.loading = (_joinActions[cell.event[@"id"]] != nil);
	if (!cell.actionTapped)
	{
		cell.actionTapped = ^(NSNumber *eventId, BOOL join) {
			if (!_joinActions[eventId])
			{
				if (join)
				{
					_joinActions[eventId] = [[NPCooleafClient sharedClient] joinEventWithId:eventId completion:^(NSError *error) {
						[_joinActions removeObjectForKey:eventId];
						NPInterestCell *c = (NPInterestCell *)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:row+1 inSection:0]];
						if (c)
							[c closeDrawer];
						
						
						[self reloadEvents];
					}];
				}
				else
				{
					_joinActions[eventId] = [[NPCooleafClient sharedClient] leaveEventWithId:eventId completion:^(NSError *error) {
						[_joinActions removeObjectForKey:eventId];
						NPInterestCell *c = (NPInterestCell *)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:row+1 inSection:0]];
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForOtherEventAtIndex:(NSInteger)row
{
	NPInterestCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NPOtherInterestCell"];
	
	cell.event = _otherEvents[row];
	cell.loading = (_joinActions[cell.event[@"id"]] != nil);
	if (!cell.actionTapped)
	{
		cell.actionTapped = ^(NSNumber *eventId, BOOL join) {
			if (!_joinActions[eventId])
			{
				if (join)
				{
					_joinActions[eventId] = [[NPCooleafClient sharedClient] joinEventWithId:eventId completion:^(NSError *error) {
						[_joinActions removeObjectForKey:eventId];
						NPInterestCell *c = (NPInterestCell *)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:_myEvents.count + 2 + row inSection:0]];
						if (c)
							[c closeDrawer];
						
						
						[self reloadEvents];
					}];
				}
				else
				{
					_joinActions[eventId] = [[NPCooleafClient sharedClient] leaveEventWithId:eventId completion:^(NSError *error) {
						[_joinActions removeObjectForKey:eventId];
						NPInterestCell *c = (NPInterestCell *)[tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:_myEvents.count + 2 + row inSection:0]];
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.row == 0)
		return [tableView dequeueReusableCellWithIdentifier:@"NPInterestTopCell"];
	else if (indexPath.row - 1 < _myEvents.count)
		return [self tableView:tableView cellForMyEventAtIndex:indexPath.row - 1];
	else if (indexPath.row - 1 > _myEvents.count)
		return [self tableView:tableView cellForOtherEventAtIndex:indexPath.row - _myEvents.count - 2];
	else
	{
		UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NPEventTableSeparator"];
		if (!cell)
		{
			cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"NPEventTableSeparator"];
			[cell.contentView addSubview:_otherBranchesHeader];
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
			cell.separatorInset = UIEdgeInsetsMake(0, 320, 0, 0);
		}
		
		return cell;
	}
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.row == 0)
		return 140;
<<<<<<< HEAD
	else if (indexPath.row -1 < _myEvents.count)
		return [NPInterestCell cellHeightForEvent:_myEvents[indexPath.row - 1]];
	else if (indexPath.row-1 == _myEvents.count)
	{
		return _otherBranchesHeader.frame.size.height;
	}
	else
		return [NPOtherInterestCell cellHeightForEvent:_otherEvents[indexPath.row - _myEvents.count - 2]];
=======
//	else if (indexPath.row -1 < _myEvents.count)
//		return 245;
//	else if (indexPath.row-1 == _myEvents.count)
//	{
//		return _otherBranchesHeader.frame.size.height;
//	}
//	else
//		return [NPOtherEventCell cellHeightForEvent:_otherEvents[indexPath.row - _myEvents.count - 2]];
	else return 245;
>>>>>>> a72f1ee17e4f758b128d903636069647102b0af3
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	if (indexPath.row == 0 || indexPath.row == _myEvents.count + 1)
		return;
	
	NPEventViewController *eC = [NPEventViewController new];
	eC.events = [_myEvents arrayByAddingObjectsFromArray:_otherEvents];
	eC.eventIdx = (indexPath.row - 1 < _myEvents.count) ? indexPath.row - 1 : indexPath.row - 2;
	
	[self.navigationController pushViewController:eC animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	if (section == 1)
	{
		return _otherBranchesHeader;
	}
	
	return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	if (section == 1)
		return _otherBranchesHeader.frame.size.height;
	return 0;
}
@end
