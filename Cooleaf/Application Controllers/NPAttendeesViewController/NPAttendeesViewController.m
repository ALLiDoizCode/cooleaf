//
//  NPAttendeesViewController.m
//  Cooleaf
//
//  Created by Bazyli Zygan on 07.01.2014.
//  Copyright (c) 2014 Nova Project. All rights reserved.
//

#import "NPAttendeesViewController.h"
#import "NPAttendeeCell.h"

@interface NPAttendeesViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

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
    self.title = [NSString stringWithFormat:NSLocalizedString(@"%ld Attendees", nil), _attendees.count];
    [_tableView registerNib:[UINib nibWithNibName:@"NPAttendeeCell" bundle:nil] forCellReuseIdentifier:@"NPAttendeeCell"];
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
