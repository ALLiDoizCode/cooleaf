//
//  NPNewTodoViewController.m
//  Cooleaf
//
//  Created by Bazyli Zygan on 07.01.2014.
//  Copyright (c) 2014 Nova Project. All rights reserved.
//

#import "NPNewTodoViewController.h"
#import "NPCooleafClient.h"

@interface NPNewTodoViewController ()
{
    AFHTTPRequestOperation *_operation;
}

@property (weak, nonatomic) IBOutlet UILabel *eventTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *placeholderLabel;
@property (weak, nonatomic) IBOutlet UITextView *todoNameView;

- (void)cancelTapped:(id)sender;
- (void)saveTapped:(id)sender;
@end

@implementation NPNewTodoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Add Todo", @"Add todo view title");
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Cancel", @"Cancel button title")
                                                                                 style:UIBarButtonItemStylePlain target:self action:@selector(cancelTapped:)];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Done", @"Done button title")
                                                                                  style:UIBarButtonItemStyleDone target:self action:@selector(saveTapped:)];
        
        self.navigationItem.rightBarButtonItem.enabled = NO;
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _eventTitleLabel.text = _event[@"name"];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [_todoNameView becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)cancelTapped:(id)sender
{
    if (_operation)
    {
        [_operation cancel];
        _operation = nil;
    }
    else
        [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)saveTapped:(id)sender
{
    NSNumber *wId = nil;
    for (NSDictionary *widget in _event[@"widgets"])
    {
        if ([widget[@"type"] isEqualToString:@"todo"])
        {
            wId = widget[@"id"];
            break;
        }
    }
    UIActivityIndicatorView *aV = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:aV];
    [aV startAnimating];
    [_todoNameView setEditable:NO];
    
    _operation = [[NPCooleafClient sharedClient] addTodoForWidget:wId name:_todoNameView.text completion:^(NSError *error) {
        _operation = nil;

        if (error)
        {
            [_todoNameView setEditable:YES];            
            self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"Done", @"Done button title")
                                                                                      style:UIBarButtonItemStyleDone target:self action:@selector(saveTapped:)];
            [_todoNameView becomeFirstResponder];
        }
        else
        {
            _operation = [[NPCooleafClient sharedClient] fetchEventWithId:_event[@"id"] completion:^(NSDictionary *eventDetails) {
                self.event = eventDetails;
                _operation = nil;
                [self dismissViewControllerAnimated:YES completion:nil];
            }];

        }
    }];
}

- (void)textViewDidChange:(UITextView *)textView
{
    if (textView.text.length > 0)
    {
        self.navigationItem.rightBarButtonItem.enabled = YES;
        _placeholderLabel.hidden = YES;
    }
    else
    {
        self.navigationItem.rightBarButtonItem.enabled = NO;
        _placeholderLabel.hidden = NO;
    }
}

@end
