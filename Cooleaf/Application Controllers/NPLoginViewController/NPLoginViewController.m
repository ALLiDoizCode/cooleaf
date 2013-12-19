//
//  NPLoginViewController.m
//  Cooleaf
//
//  Created by Bazyli Zygan on 14.12.2013.
//  Copyright (c) 2013 Nova Project. All rights reserved.
//

#import "NPLoginViewController.h"
#import "NPCooleafClient.h"
#import "UIBarButtonItem+NPBarButtonItems.h"

#define UPSHIFT 101

@interface NPLoginViewController ()
{
    AFHTTPRequestOperation *_loginOperation;
}
@property (strong, nonatomic) IBOutlet UITextField *usernameField;
@property (strong, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIButton *forgotPasswdBtn;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *footerView;

- (IBAction)signInTapped:(id)sender;
- (IBAction)forgotPasswdTapped:(id)sender;
- (void)cancelLogin:(id)sender;

@end

@implementation NPLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.title = NSLocalizedString(@"Welcome", @"Login screen title");
        self.navigationItem.rightBarButtonItem = [UIBarButtonItem buttonItemWithTitle:NSLocalizedString(@"Sign in", @"sign in button title")
                                                                               target:self selector:@selector(signInTapped:)];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _forgotPasswdBtn.titleLabel.font = [UIFont mediumApplicationFontOfSize:15];
    _tableView.tableFooterView = _footerView;
    _usernameField = [[UITextField alloc] initWithFrame:CGRectMake(15, 0, 290, 44)];
    _usernameField.placeholder = NSLocalizedString(@"Email address", @"Email address placeholder on login screen");
    _usernameField.font = [UIFont mediumApplicationFontOfSize:15];
    _usernameField.delegate = self;
    _usernameField.returnKeyType = UIReturnKeyNext;
    _usernameField.keyboardType = UIKeyboardTypeEmailAddress;
    _usernameField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    _passwordField = [[UITextField alloc] initWithFrame:CGRectMake(15, 0, 290, 44)];
    _passwordField.placeholder = NSLocalizedString(@"Password", @"Password placeholder on login screen");
    _passwordField.font = [UIFont mediumApplicationFontOfSize:15];
    _passwordField.delegate = self;
    _passwordField.returnKeyType = UIReturnKeySend;
    _passwordField.secureTextEntry = YES;

    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"username"])
    {
        _usernameField.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
        [_passwordField becomeFirstResponder];
    }
    else
    {
        [_usernameField becomeFirstResponder];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)unlockView
{
    _loginOperation = nil;
    self.title = NSLocalizedString(@"Welcome", @"Login view title");
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem buttonItemWithTitle:NSLocalizedString(@"Sign in", @"sign in button title")
                                                                           target:self selector:@selector(signInTapped:)];
    _usernameField.enabled = YES;
    _passwordField.enabled = YES;
    _forgotPasswdBtn.enabled = YES;
}

- (IBAction)signInTapped:(id)sender
{
    [_usernameField resignFirstResponder];
    [_passwordField resignFirstResponder];
    
    if (_usernameField.text.length < 5 || _passwordField.text.length == 0)
    {
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Sign in failed", @"Sign in failure alert title")
                                                     message:NSLocalizedString(@"Given username or password is too short.", @"Wrong credentials given. Too little data")
                                                    delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
        [av show];
        return;
    }
    
    // Testing
    self.title = NSLocalizedString(@"Loading...", @"Login view title during login action");
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem buttonItemWithTitle:NSLocalizedString(@"Cancel", @"Cancel button on login screen")
                                                                          target:self selector:@selector(cancelLogin:)];
    UIActivityIndicatorView *aV = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:aV];
    [aV startAnimating];
    
    _usernameField.enabled = NO;
    _passwordField.enabled = NO;
    _forgotPasswdBtn.enabled = NO;
    _loginOperation = [[NPCooleafClient sharedClient] loginWithUsername:_usernameField.text password:_passwordField.text completion:^(NSError *error) {
        [self unlockView];
        if (error)
        {
            UIAlertView *av = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Sign in failed", @"Sign in failure alert title")
                                                         message:NSLocalizedString(@"Wrong username or password", @"Wrong credentials given. Server responded with error")
                                                        delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
            [av show];
        }
        else
        {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        
    }];
    
}

- (void)cancelLogin:(id)sender
{
    [_loginOperation cancel];
    [self unlockView];
}

- (IBAction)forgotPasswdTapped:(id)sender {
}

- (int)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LoginCell"];
    
    [cell.contentView addSubview:((indexPath.row == 0) ? _usernameField : _passwordField)];
    UIView *sep = [[UIView alloc] initWithFrame:CGRectMake(0, (indexPath.row == 0) ? 0 : 43, 320, 1)];
    sep.backgroundColor = [UIColor colorWithRed:214.0/255.0 green:214.0/255.0 blue:220.0/255.0 alpha:1];
    [cell.contentView addSubview:sep];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return (section == 0) ? 50.0 : 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (_usernameField == textField)
        [_passwordField becomeFirstResponder];
    else if (_passwordField == textField)
        [self signInTapped:nil];
    
    return YES;
}


@end
