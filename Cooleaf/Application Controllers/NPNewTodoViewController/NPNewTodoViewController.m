//
//  NPNewTodoViewController.m
//  Cooleaf
//
//  Created by Bazyli Zygan on 07.01.2014.
//  Copyright (c) 2014 Nova Project. All rights reserved.
//

#import "NPNewTodoViewController.h"

@interface NPNewTodoViewController ()

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
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)saveTapped:(id)sender
{
    
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
