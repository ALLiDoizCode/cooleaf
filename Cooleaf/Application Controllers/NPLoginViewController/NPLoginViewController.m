//
//  NPLoginViewController.m
//  Cooleaf
//
//  Created by Bazyli Zygan on 14.12.2013.
//  Copyright (c) 2013 Nova Project. All rights reserved.
//

#import "NPLoginViewController.h"
#import "NPCooleafClient.h"

#define UPSHIFT 101

@interface NPLoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIButton *signInBtn;
@property (weak, nonatomic) IBOutlet UIButton *forgotPasswdBtn;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UIView *signInBtnBg;
@property (weak, nonatomic) IBOutlet UIImageView *logoView;
@property (weak, nonatomic) IBOutlet UIView *credentialsView;

- (IBAction)signInTapped:(id)sender;
- (IBAction)forgotPasswdTapped:(id)sender;

- (void)keyboardWillShow:(NSNotification *)not;
- (void)keyboardWillHide:(NSNotification *)not;

@end

@implementation NPLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _signInBtnBg.layer.cornerRadius = 3.0;
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"username"])
    {
        _usernameField.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    _usernameField.enabled = NO;
    _passwordField.enabled = NO;
    _signInBtn.enabled = NO;
    _forgotPasswdBtn.enabled = NO;
    [_activityIndicator startAnimating];
    [[NPCooleafClient sharedClient] loginWithUsername:_usernameField.text password:_passwordField.text completion:^(NSError *error) {
        [_activityIndicator stopAnimating];
        _usernameField.enabled = YES;
        _passwordField.enabled = YES;
        _signInBtn.enabled = YES;
        _forgotPasswdBtn.enabled = YES;
        
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

- (IBAction)forgotPasswdTapped:(id)sender {
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (_usernameField == textField)
        [_passwordField becomeFirstResponder];
    else if (_passwordField == textField)
        [self signInTapped:_signInBtn];
    
    return YES;
}

- (void)keyboardWillShow:(NSNotification *)not
{
    if ([UIScreen mainScreen].bounds.size.height > 500)
        return;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationCurve:[[[not userInfo] objectForKey:UIKeyboardAnimationCurveUserInfoKey] intValue]];
    [UIView setAnimationDuration:[[[not userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue]];
    
    _logoView.alpha = 0.0;
    _credentialsView.transform = CGAffineTransformMakeTranslation(0, 0-UPSHIFT);
    _signInBtnBg.transform = CGAffineTransformMakeTranslation(0, 0-UPSHIFT);
    _forgotPasswdBtn.transform = CGAffineTransformMakeTranslation(0, 0-UPSHIFT);
    [UIView commitAnimations];
}

- (void)keyboardWillHide:(NSNotification *)not
{
    if ([UIScreen mainScreen].bounds.size.height > 500)
        return;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationCurve:[[[not userInfo] objectForKey:UIKeyboardAnimationCurveUserInfoKey] intValue]];
    [UIView setAnimationDuration:[[[not userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue]];
    
    _logoView.alpha = 1.0;
    _credentialsView.transform = CGAffineTransformIdentity;
    _signInBtnBg.transform = CGAffineTransformIdentity;
    _forgotPasswdBtn.transform = CGAffineTransformIdentity;
    [UIView commitAnimations];
}

@end
