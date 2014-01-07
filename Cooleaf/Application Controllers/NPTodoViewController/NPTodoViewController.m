//
//  NPTodoViewController.m
//  Cooleaf
//
//  Created by Bazyli Zygan on 07.01.2014.
//  Copyright (c) 2014 Nova Project. All rights reserved.
//

#import "NPTodoViewController.h"
#import "NPTodoCell.h"
#import "NPNewTodoViewController.h"

@interface NPTodoViewController ()
{
    NSDictionary *_todosNode;
}

@property (weak, nonatomic) IBOutlet UILabel *emptyPlaceholder;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (void)addTodoTapped:(id)sender;
@end

@implementation NPTodoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"To Be Done", @"Todo view title");
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"Add"] style:UIBarButtonItemStylePlain target:self action:@selector(addTodoTapped:)];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [_tableView registerNib:[UINib nibWithNibName:@"NPTodoCell" bundle:nil] forCellReuseIdentifier:@"NPTodoCell"];
    // We need to find a todos node to show up
    for (NSDictionary *widget in _event[@"widgets"])
    {
        if ([widget[@"type"] isEqualToString:@"todo"])
        {
            _todosNode = widget;
            break;
        }
    }
    
    // Now we can do the rest
    if ([_todosNode[@"propositions"] count] > 0)
    {
        _emptyPlaceholder.hidden = YES;
        _tableView.hidden = NO;
        [_tableView reloadData];
    }
    else
    {
        _emptyPlaceholder.hidden = NO;
        _tableView.hidden = YES;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)addTodoTapped:(id)sender
{
    NPNewTodoViewController *nT = [NPNewTodoViewController new];
    nT.event = _event;
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:nT] animated:YES completion:nil];
}

#pragma mark - UITableView stuff

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_todosNode[@"propositions"] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NPTodoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NPTodoCell"];
    
    cell.todo = _todosNode[@"propositions"][indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [NPTodoCell cellHeightForTodo:_todosNode[@"propositions"][indexPath.row]];
}


@end
