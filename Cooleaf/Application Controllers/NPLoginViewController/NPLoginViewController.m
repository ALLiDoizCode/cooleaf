//
//  NPLoginViewController.m
//  Cooleaf
//
//  Created by Bazyli Zygan on 14.12.2013.
//  Copyright (c) 2013 Nova Project. All rights reserved.
//

#import <SSKeychain/SSKeychain.h>
#import "NPLoginViewController.h"
#import "NPCooleafClient.h"
#import "UIBarButtonItem+NPBarButtonItems.h"

#define UPSHIFT 101

@interface NPLoginViewController ()
{
    AFHTTPRequestOperation *_loginOperation;
}
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIButton *forgotPasswdBtn;
@property (weak, nonatomic) IBOutlet UIButton *signInBtn;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@property (weak, nonatomic) IBOutlet UIView *containerView;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *globalSpinner;
@property (weak, nonatomic) IBOutlet UIImageView *logoView;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundView;

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
        self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _containerView.hidden = YES;
    _forgotPasswdBtn.hidden = YES;
    _containerView.layer.cornerRadius = 4.0;
    
    if ([UIScreen mainScreen].bounds.size.height < 500)
    {
        _containerView.transform = CGAffineTransformMakeTranslation(0, -100);
        _forgotPasswdBtn.transform = CGAffineTransformMakeTranslation(0, -170);
        _logoView.transform = CGAffineTransformMakeTranslation(-2, -48);
        _globalSpinner.transform = CGAffineTransformMakeTranslation(0, -80);
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        _logoView.alpha = 0.0;
    } completion:^(BOOL finished) {
        _logoView.hidden = YES;
        
        NSString *username = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
        if (username && [SSKeychain passwordForService:@"cooleaf" account:username])
        {
            [_globalSpinner startAnimating];
            _loginOperation = [[NPCooleafClient sharedClient] loginWithUsername:username password:[SSKeychain passwordForService:@"cooleaf" account:username]
                                                                     completion:^(NSError *error) {
                if (error)
                {
                    [self unlockView];
                }
                else
                {
                    [self dismissViewControllerAnimated:YES completion:nil];
                }
            }];
        }
        else
        {
            _containerView.alpha = 0.0;
            _containerView.hidden = NO;
            _forgotPasswdBtn.hidden = NO;
            [UIView animateWithDuration:0.3 animations:^{
                _containerView.alpha = 1.0;
                _forgotPasswdBtn.alpha = 1.0;
            } completion:^(BOOL finished) {
                if (username)
                {
                    _usernameField.text = username;
                    [_passwordField becomeFirstResponder];
                }
                else
                {
                    [_usernameField becomeFirstResponder];
                }
                
            }];
        }

    }];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)unlockView
{
    _loginOperation = nil;
    [_spinner stopAnimating];
    [_globalSpinner stopAnimating];
    if (_containerView.hidden)
    {
        _containerView.alpha = 0.0;
        _containerView.hidden = NO;
        _forgotPasswdBtn.hidden = NO;
        [UIView animateWithDuration:0.3 animations:^{
            _containerView.alpha = 1.0;
            _forgotPasswdBtn.alpha = 1.0;
        } completion:^(BOOL finished) {
            NSString *username = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
            if (username)
            {
                _usernameField.text = username;
                [_passwordField becomeFirstResponder];
            }
            else
            {
                [_usernameField becomeFirstResponder];
            }
        }];
    }
    [_forgotPasswdBtn setTitle:NSLocalizedString(@"Forgot password?", @"Forgot password button title on login screen") forState:UIControlStateNormal];
    _signInBtn.hidden = NO;
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
    _signInBtn.hidden = YES;
    [_forgotPasswdBtn setTitle:NSLocalizedString(@"Cancel", @"Cancel button title on login screen") forState:UIControlStateNormal];
    [_spinner startAnimating];
    _usernameField.enabled = NO;
    _passwordField.enabled = NO;
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

- (IBAction)forgotPasswdTapped:(id)sender
{
    if (_loginOperation)
        [self cancelLogin:sender];
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
