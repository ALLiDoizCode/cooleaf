//
//  NPEventViewController.m
//  Cooleaf
//
//  Created by Bazyli Zygan on 06.01.2014.
//  Copyright (c) 2014 Nova Project. All rights reserved.
//

#import "NPEventViewController.h"
#import "NPCooleafClient.h"
#import "NPAttendeesViewController.h"
#import "NPTodoViewController.h"

// Cells
#import "NPAttendeesCell.h"
#import "NPDateCell.h"
#import "NPLocationCell.h"
#import "NPDetailsCell.h"
#import "NPTodosCell.h"

enum {
    NPEventCell_Attendees = 0,
    NPEventCell_Date,
    NPEventCell_Location,
    NPEventCell_Details,
    NPEventCell_Todos,
    
    NPEventCell_Count
};

@interface NPEventViewController ()
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
@property (weak, nonatomic) IBOutlet UIView *topSeparator;
@property (weak, nonatomic) IBOutlet UIView *backgroundView;
@property (weak, nonatomic) IBOutlet UILabel *rewardLabel;

- (void)setEvent:(NSDictionary *)event;
- (IBAction)joinTapped:(id)sender;

- (IBAction)switchEventTapped:(UIButton *)sender;
- (IBAction)resignTapped:(id)sender;

- (void)updateJoinButton;
- (void)updateCells;
- (void)notificationReceived:(NSNotification *)not;

@end

@implementation NPEventViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]
                                                 initWithTitle:NSLocalizedString(@"Event", nil)
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
    [_tableView registerNib:[UINib nibWithNibName:@"NPAttendeesCell" bundle:nil] forCellReuseIdentifier:@"NPAttendeesCell"];
    [_tableView registerNib:[UINib nibWithNibName:@"NPDateCell" bundle:nil] forCellReuseIdentifier:@"NPDateCell"];
    [_tableView registerNib:[UINib nibWithNibName:@"NPLocationCell" bundle:nil] forCellReuseIdentifier:@"NPLocationCell"];
    [_tableView registerNib:[UINib nibWithNibName:@"NPDetailsCell" bundle:nil] forCellReuseIdentifier:@"NPDetailsCell"];
    [_tableView registerNib:[UINib nibWithNibName:@"NPTodosCell" bundle:nil] forCellReuseIdentifier:@"NPTodosCell"];
    
    _tableView.tableHeaderView = _tableHeaderView;
//    [self setEvent:_events[_eventIdx]];
    
    CGRect f = _topSeparator.frame;
    f.size.height = 0.5;
    f.origin.y += 0.5;
    _topSeparator.frame = f;
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
    _topSeparator.hidden = YES;
    [_tableView reloadData];
    
    
//    // Button border
//    _joinButton.layer.borderWidth = 1;
//    _joinButton.layer.borderColor = _joinButton.titleLabel.textColor.CGColor;
//    _joinButton.layer.cornerRadius = 2.0;
//    
    // Set cover image
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
	
    // Calculate size for hashes
    NSMutableString *hashes = [NSMutableString string];
    for (NSString *hash in event[@"categories_names"])
    {
        if (hashes.length > 0)
            [hashes appendFormat:@" #%@", hash];
        else
            [hashes appendFormat:@"#%@", hash];
    }
    
    _categoriesLabel.text = [hashes uppercaseString];
    f = _categoriesLabel.frame;
    [_categoriesLabel sizeToFit];
    _categoriesLabel.frame = CGRectMake(f.origin.x, 75 + shift, f.size.width, _categoriesLabel.frame.size.height);
//    shift += _categoriesLabel.frame.size.height;
	
    // Move necessary elements down
    _joinButton.transform = CGAffineTransformMakeTranslation(0, shift);
//    _rewardLabel.transform = CGAffineTransformMakeTranslation(0, shift);
    _loadingIndicator.transform = CGAffineTransformMakeTranslation(0, shift);
    _resignButton.transform = CGAffineTransformMakeTranslation(0, shift);
    _topSeparator.transform = CGAffineTransformMakeTranslation(0, shift);
    _shift = shift;
    // Assign global information
    _rewardLabel.text = [NSString stringWithFormat:NSLocalizedString(@"%@ reward points", @"reward points string on event details page"), event[@"reward_points"]];
	if ([event[@"reward_points"] intValue] == 0) {
		_rewardLabel.hidden = TRUE;
	}
    // Resize header
    f = _tableHeaderView.frame;
    f.size.height = 185;
    _tableHeaderView.frame = f;
	f = _backgroundView.frame;
	f.size.height = 185;
	_backgroundView.frame = f;
    
    // Reassign header again
    _tableView.tableHeaderView = _tableHeaderView;
    
    // Time to hide buttons and download details
    _joinButton.hidden = YES;
    _resignButton.hidden = YES;
    [_loadingIndicator startAnimating];
    _fetchingOperation = [[NPCooleafClient sharedClient] fetchEventWithId:event[@"id"] completion:^(NSDictionary *eventDetails) {
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
    _joinButton.enabled = ![_currentEvent[@"attending"] boolValue];
    _resignButton.hidden = ![_currentEvent[@"attending"] boolValue];
    _joinButton.hidden = [_currentEvent[@"attending"] boolValue];
    
    if ([_currentEvent[@"attending"] boolValue])
    {
		_joinButton.frame = CGRectMake(260, 135, 60, 25);
		_resignButton.frame = CGRectMake(260, 135, 60, 25);
    }
    else
    {
		_joinButton.frame = CGRectMake(260, 135, 60, 25);
		_resignButton.frame = CGRectMake(260, 135, 60, 25);
    }
//    _joinButton.transform = CGAffineTransformMakeTranslation(0, _shift);
}

- (void)updateCells
{
    _topSeparator.hidden = YES;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView reloadData];
}

- (IBAction)joinTapped:(id)sender
{
    _joinButton.hidden = YES;
    _resignButton.hidden = YES;
    [_loadingIndicator startAnimating];
    _fetchingOperation = [[NPCooleafClient sharedClient] joinEventWithId:_currentEvent[@"id"] completion:^(NSError *error) {
        _fetchingOperation = [[NPCooleafClient sharedClient] fetchEventWithId:_currentEvent[@"id"] completion:^(NSDictionary *eventDetails) {
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
        _fetchingOperation = [[NPCooleafClient sharedClient] leaveEventWithId:_currentEvent[@"id"] completion:^(NSError *error) {
            _fetchingOperation = [[NPCooleafClient sharedClient] fetchEventWithId:_currentEvent[@"id"] completion:^(NSDictionary *eventDetails) {
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
            NPAttendeesCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NPAttendeesCell"];
            cell.selfAttended = [_currentEvent[@"attending"] boolValue];
            cell.attendeesCount = [_currentEvent[@"participants_count"] unsignedIntegerValue];
            cell.attendees = _currentEvent[@"participants"];
            return cell;
            
        }
        break;
            
        case NPEventCell_Date:
        {
            NPDateCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NPDateCell"];
            cell.dateString = _currentEvent[@"start_time"];
            cell.title = _currentEvent[@"name"];
            return cell;
        }
        break;
            
        case NPEventCell_Location:
        {
            NPLocationCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NPLocationCell"];
            cell.address = _currentEvent[@"address"];
            return cell;
        }
        break;
            
        case NPEventCell_Details:
        {
            NPDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NPDetailsCell"];
            cell.detailsText = _currentEvent[@"description"];
            return cell;
        }
        break;
            
        case NPEventCell_Todos:
        {
            NPTodosCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NPTodosCell"];
            // Find appropriate widget
            for (NSDictionary *widget in _currentEvent[@"widgets"])
            {
                if ([widget[@"type"] isEqualToString:@"todo"])
                {
                    cell.todosCount = [widget[@"propositions"] count];
                    break;
                }
            }
            return cell;
        }
            break;
        default:
            return nil;
            break;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case NPEventCell_Attendees:
            if ([_currentEvent[@"participants_count"] integerValue] > 0)
                return 50.0;
            else
                return 44.0;
            break;
            
        case NPEventCell_Date:
            return 94.0;
            break;

        case NPEventCell_Location:
            if (_currentEvent[@"address"][@"lat"])
                return 176;
            else
                return 94.0;
            break;
            
        case NPEventCell_Todos:
            return 53.0;
            break;
            
        case NPEventCell_Details:
            return [NPDetailsCell cellHeightForText:_currentEvent[@"description"]];
            break;
        default:
            break;
    }
    
    return 0;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case NPEventCell_Attendees:
            if ([_currentEvent[@"participants_count"] integerValue] > 0)
                return YES;
            break;
        case NPEventCell_Todos:
            return YES;
            break;
        default:
            break;
    }
    
    return NO;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case NPEventCell_Todos:
        {
            NPTodoViewController *tC = [NPTodoViewController new];
            tC.event = _currentEvent;
            [self.navigationController pushViewController:tC animated:YES];
        }
            break;
        case NPEventCell_Attendees:
        {
            NPAttendeesViewController *aV = [NPAttendeesViewController new];
            aV.eventId = _currentEvent[@"id"];
            aV.attendeesCount = [_currentEvent[@"participants_count"] integerValue];
            [self.navigationController pushViewController:aV animated:YES];
        }
        default:
            break;
    }
}
@end
