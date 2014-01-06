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
@property (weak, nonatomic) IBOutlet UILabel *rewardLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingIndicator;

- (void)setEvent:(NSDictionary *)event;
- (IBAction)joinTapped:(id)sender;

- (IBAction)switchEventTapped:(UIButton *)sender;
- (IBAction)resignTapped:(id)sender;

- (void)updateJoinButton;
- (void)updateCells;

@end

@implementation NPEventViewController

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
    
    // Register cell types
    [_tableView registerNib:[UINib nibWithNibName:@"NPAttendeesCell" bundle:nil] forCellReuseIdentifier:@"NPAttendeesCell"];
    [_tableView registerNib:[UINib nibWithNibName:@"NPDateCell" bundle:nil] forCellReuseIdentifier:@"NPDateCell"];
    [_tableView registerNib:[UINib nibWithNibName:@"NPLocationCell" bundle:nil] forCellReuseIdentifier:@"NPLocationCell"];
    [_tableView registerNib:[UINib nibWithNibName:@"NPDetailsCell" bundle:nil] forCellReuseIdentifier:@"NPDetailsCell"];
    [_tableView registerNib:[UINib nibWithNibName:@"NPTodosCell" bundle:nil] forCellReuseIdentifier:@"NPTodosCell"];
    
    _tableView.tableHeaderView = _tableHeaderView;
    [self setEvent:_events[_eventIdx]];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:_eventChangeButtons];
    
    _prevEventButton.enabled = (_eventIdx != 0);
    _nextEventButton.enabled = (_eventIdx < _events.count-1);
    
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
    [_tableView reloadData];
    
    
    // Button border
    _joinButton.layer.borderWidth = 1;
    _joinButton.layer.borderColor = _joinButton.titleLabel.textColor.CGColor;
    _joinButton.layer.cornerRadius = 2.0;
    
    // Set cover image
    NSString *imageUrlString = [@"http:" stringByAppendingString:[event[@"image"][@"url"] stringByReplacingOccurrencesOfString:@"{{SIZE}}" withString:@"640x150"]];
    // Download image for event
    [[NPCooleafClient sharedClient] fetchImage:imageUrlString completion:^(NSString *imagePath, UIImage *image) {
        if ([imagePath compare:imageUrlString] == NSOrderedSame)
        {
            _coverPhotoView.image = image;
        }
    }];
    // Calculate size for title
    _titleLabel.text = event[@"name"];
    f = _titleLabel.frame;
    [_titleLabel sizeToFit];
    _titleLabel.frame = CGRectMake(f.origin.x, f.origin.y, f.size.width, _titleLabel.frame.size.height);
    shift = _titleLabel.frame.size.height;
    
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
    shift += _categoriesLabel.frame.size.height;
    
    // Move necessary elements down
    _joinButton.transform = CGAffineTransformMakeTranslation(0, shift);
    _rewardLabel.transform = CGAffineTransformMakeTranslation(0, shift);
    _loadingIndicator.transform = CGAffineTransformMakeTranslation(0, shift);
    _resignButton.transform = CGAffineTransformMakeTranslation(0, shift);
    
    // Assign global information
    _rewardLabel.text = [NSString stringWithFormat:NSLocalizedString(@"+ %@ reward points", @"reward points string on event details page"), event[@"reward_points"]];
    
    // Resize header
    f = _tableHeaderView.frame;
    f.size.height = 155 + shift;
    _tableHeaderView.frame = f;
    
    // Reassign header again
    _tableView.tableHeaderView = _tableHeaderView;
    
    // Time to hide buttons and download details
    _joinButton.hidden = YES;
    _rewardLabel.hidden = YES;
    _resignButton.hidden = YES;
    [_loadingIndicator startAnimating];
    _fetchingOperation = [[NPCooleafClient sharedClient] fetchEventWithId:event[@"id"] completion:^(NSDictionary *eventDetails) {
        [_loadingIndicator stopAnimating];
        _fetchingOperation = nil;
        if (eventDetails)
        {
            _currentEvent = event;
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
    _joinButton.layer.borderColor = [[_joinButton titleColorForState:(([_currentEvent[@"attending"] boolValue]) ? UIControlStateDisabled : UIControlStateNormal)] CGColor];
    _joinButton.enabled = ![_currentEvent[@"attending"] boolValue];
    _rewardLabel.hidden = [_currentEvent[@"attending"] boolValue];
    _resignButton.hidden = !_rewardLabel.hidden;
    _joinButton.hidden = NO;
}

- (void)updateCells
{
    [_tableView reloadData];
}

- (IBAction)joinTapped:(id)sender
{
    _joinButton.hidden = YES;
    _resignButton.hidden = YES;
    _rewardLabel.hidden = YES;
    [_loadingIndicator startAnimating];
    _fetchingOperation = [[NPCooleafClient sharedClient] joinEventWithId:_currentEvent[@"id"] completion:^(NSError *error) {
        if (!error)
        {
            _fetchingOperation = [[NPCooleafClient sharedClient] fetchEventWithId:_currentEvent[@"id"] completion:^(NSDictionary *eventDetails) {
                [_loadingIndicator stopAnimating];
                _fetchingOperation = nil;
                _currentEvent = eventDetails;
                // Update button
                [self updateJoinButton];
                
                // And build cells
                [self updateCells];
                
            }];
        }
        else
        {
            _fetchingOperation = nil;
            [_loadingIndicator stopAnimating];
            
            // Update button
            [self updateJoinButton];
        }
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
    UIActionSheet *as = [[UIActionSheet alloc] initWithTitle:NSLocalizedString(@"Do you really want to resign?", nil)
                                                    delegate:self cancelButtonTitle:NSLocalizedString(@"Cancel", nil)
                                      destructiveButtonTitle:NSLocalizedString(@"Yes, I want to resign", nil) otherButtonTitles:nil];
    
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
            if (!error)
            {
                _fetchingOperation = [[NPCooleafClient sharedClient] fetchEventWithId:_currentEvent[@"id"] completion:^(NSDictionary *eventDetails) {
                    [_loadingIndicator stopAnimating];
                    _fetchingOperation = nil;
                    _currentEvent = eventDetails;
                    // Update button
                    [self updateJoinButton];
                    
                    // And build cells
                    [self updateCells];
                    
                }];
            }
            else
            {
                _fetchingOperation = nil;
                [_loadingIndicator stopAnimating];
                
                // Update button
                [self updateJoinButton];
            }
        }];
    }
}

#pragma mark - UITableView stuff

- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
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
            if ([_currentEvent[@"participants"] count] > 0)
                return 79.0;
            else
                return 44.0;
            break;
            
        case NPEventCell_Date:
            return 94.0;
            break;

        case NPEventCell_Location:
            return 163.0;
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
            if ([_currentEvent[@"participants"] count] > 0)
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
            NSLog(@"Show me todo list");
        }
            break;
        case NPEventCell_Attendees:
        {
            NPAttendeesViewController *aV = [NPAttendeesViewController new];
            aV.attendees = _currentEvent[@"participants"];
            [self.navigationController pushViewController:aV animated:YES];
        }
        default:
            break;
    }
}
@end
