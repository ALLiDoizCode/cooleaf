//
//  NPLoginViewController.m
//  Cooleaf
//
//  Created by Bazyli Zygan on 14.12.2013.
//  Copyright (c) 2013 Nova Project. All rights reserved.
//

#import <SSKeychain/SSKeychain.h>
#import "NPLoginViewController.h"
#import "NPRegistrationViewController.h"
#import "NPCooleafClient.h"
#import "UIBarButtonItem+NPBarButtonItems.h"
#import "CLAuthenticationPresenter.h"

#define UPSHIFT 101

@interface NPLoginViewController ()
{
    AFHTTPRequestOperation *_loginOperation;
}

@property (nonatomic, strong) CLAuthenticationPresenter *authenticationPresenter;
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIButton *forgotPasswdBtn;
@property (weak, nonatomic) IBOutlet UIButton *signInBtn;
@property (weak, nonatomic) IBOutlet UIButton *signUpButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UIView *loginHighlight;
@property (weak, nonatomic) IBOutlet UIButton *loginTabButton;
@property (weak, nonatomic) IBOutlet UIButton *signupTabButton;
@property (weak, nonatomic) IBOutlet UIView *signupHighlight;
@property (weak, nonatomic) IBOutlet UIButton *termsButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *globalSpinner;
@property (weak, nonatomic) IBOutlet UIImageView *logoView;

- (IBAction)signInTapped:(id)sender;
- (IBAction)forgotPasswdTapped:(id)sender;
- (void)cancelLogin:(id)sender;
- (IBAction)loginTabTapped:(id)sender;
- (IBAction)signupTabTapped:(id)sender;
- (IBAction)signupButtonTapped:(id)sender;
- (IBAction)termsButtonTapped:(id)sender;

@end

@implementation NPLoginViewController

# pragma mark - initWithNibName

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    }
    return self;
}

# pragma mark - startLogin

- (void)startLogin {
    [UIView animateWithDuration:0.3 animations:^{
        //_logoView.alpha = 0.0;
    } completion:^(BOOL finished) {
        //_logoView.hidden = YES;
		
        NSString *username = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
        NSString *password = [SSKeychain passwordForService:@"cooleaf" account:username];
        NSLog(@"Username is: %@", username);
        NSLog(@"Password is: %@", password);
        if (username && [SSKeychain passwordForService:@"cooleaf" account:username]) {
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
        } else {
            _containerView.alpha = 0.0;
            _containerView.hidden = NO;
            _forgotPasswdBtn.hidden = YES;
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

- (void)notificationUDIDReceived:(NSNotification *)not {
    [self startLogin];
}

# pragma mark - LifeCycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
    if ([NPCooleafClient sharedClient].notificationUDID) {
        NSLog(@"%@", [NPCooleafClient sharedClient].notificationUDID);
        NSLog(@"Has notificationUDID, starting login...");
        [self startLogin];
    } else {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationUDIDReceived:) name:kNPCooleafClientRUDIDHarvestedNotification object:nil];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	[self.navigationController setNavigationBarHidden:TRUE];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma mark - setupUI

- (void)setupUI {
    _containerView.hidden = YES;
    _forgotPasswdBtn.hidden = YES;
    _containerView.layer.cornerRadius = 4.0;
    _loginHighlight.alpha = 1.0;
    _signupHighlight.alpha = 0.0;
    _signUpButton.alpha = 0.0;
    _signUpButton.hidden = YES;
    _termsButton.alpha = 0.0;
    
    if ([UIScreen mainScreen].bounds.size.height < 500) {
        _containerView.transform = CGAffineTransformMakeTranslation(0, -100);
        _forgotPasswdBtn.transform = CGAffineTransformMakeTranslation(0, -170);
        _logoView.transform = CGAffineTransformMakeTranslation(-2, -48);
        _globalSpinner.transform = CGAffineTransformMakeTranslation(0, -80);
    }

}

# pragma mark - checkLogin

# pragma mark - preferredStatusBarStyle

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

# pragma mark - unlockView

- (void)unlockView {
    _loginOperation = nil;
    [_spinner stopAnimating];
    [_globalSpinner stopAnimating];
    if (_containerView.hidden) {
        _containerView.alpha = 0.0;
        _containerView.hidden = NO;
        _forgotPasswdBtn.hidden = YES;
        [UIView animateWithDuration:0.3 animations:^{
            _containerView.alpha = 1.0;
            _forgotPasswdBtn.alpha = 1.0;
        } completion:^(BOOL finished) {
            NSString *username = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
            if (username) {
                _usernameField.text = username;
                [_passwordField becomeFirstResponder];
            } else {
                [_usernameField becomeFirstResponder];
            }
        }];
    }
    [_forgotPasswdBtn setTitle:NSLocalizedString(@"Forgot password?", @"Forgot password button title on login screen") forState:UIControlStateNormal];
    _signInBtn.hidden = NO;
    _usernameField.enabled = YES;
    _passwordField.enabled = YES;
    _forgotPasswdBtn.enabled = NO;
}

# pragma mark - signInTapped

- (IBAction)signInTapped:(id)sender {
    [_usernameField resignFirstResponder];
    [_passwordField resignFirstResponder];
    
    if (_usernameField.text.length < 5 || _passwordField.text.length == 0) {
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
        if (error) {
            UIAlertView *av = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Log In Failed", @"Sign in failure alert title")
                                                         message:NSLocalizedString(@"Invalid username/password or account not yet activated. Please ‘Sign Up’ to activate your account or try again with your corporate email.", @"Wrong credentials given. Server responded with error")
                                                        delegate:nil cancelButtonTitle:NSLocalizedString(@"OK", nil) otherButtonTitles: nil];
            [av show];
            
        } else {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        
    }];
    
}

# pragma mark - signupButtonTapped

- (IBAction)signupButtonTapped:(id)sender {
	[_usernameField resignFirstResponder];
	[_passwordField resignFirstResponder];
	
	if (_usernameField.text.length < 8 || _passwordField.text.length < 8) {
		[[[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Registration failed", @"Registration failure alert title")
																message:NSLocalizedString(@"Given username or password is too short. (minimum is 8 characters)", @"Invalid credentials given. Too little data")
															 delegate:nil
											cancelButtonTitle:NSLocalizedString(@"OK", nil)
											otherButtonTitles: nil] show];
		return;
	}
	
	NPRegistrationViewController *controller = [[NPRegistrationViewController alloc] initWithUsername:_usernameField.text andPassword:_passwordField.text];
	[self.navigationController pushViewController:controller animated:TRUE];
}

# pragma mark - termsButtonTapped

- (IBAction)termsButtonTapped:(id)sender {
	NSURL *termsURL = [NSURL URLWithString:@"http://www.cooleaf.com/pages/tos/"];
	[[UIApplication sharedApplication] openURL:termsURL];
}

# pragma mark - cancelLogin

- (void)cancelLogin:(id)sender {
    [_loginOperation cancel];
    [self unlockView];
}

# pragma mark - loginTabTapped

- (IBAction)loginTabTapped:(id)sender {
	[UIView animateWithDuration:0.5 animations:^{
		_loginHighlight.alpha = 1.0;
		_signupHighlight.alpha = 0.0;
		_signUpButton.hidden = YES;
		_signUpButton.alpha = 0.0;
		_signInBtn.hidden = NO;
		_signInBtn.alpha = 1.0;
		_termsButton.alpha = 0.0;
		_passwordField.placeholder = @"Password";
		[self.view bringSubviewToFront:_signInBtn];
	} completion:^(BOOL finished) {
	}];

}

# pragma mark - signupTabTapped

- (IBAction)signupTabTapped:(id)sender {
	[UIView animateWithDuration:0.5 animations:^{
		_loginHighlight.alpha = 0.0;
		_signupHighlight.alpha = 1.0;
		_signUpButton.hidden = NO;
		_signUpButton.alpha = 1.0;
		_signInBtn.hidden = YES;
		_signInBtn.alpha = 0.0;
		_termsButton.alpha = 1.0;
		_passwordField.placeholder = @"Create Password";
		[self.view bringSubviewToFront:_signUpButton];
	} completion:^(BOOL finished) {
	}];
}

# pragma mark - forgotPasswdTapped

- (IBAction)forgotPasswdTapped:(id)sender {
    if (_loginOperation)
        [self cancelLogin:sender];
    else {
        NSURL *forgotPwdURL = [[NPCooleafClient sharedClient].baseURL URLByAppendingPathComponent:@"/users/password/new"];
        [[UIApplication sharedApplication] openURL:forgotPwdURL];
    }
}

# pragma mark - textFieldShouldReturn

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (_usernameField == textField)
        [_passwordField becomeFirstResponder];
	else if (_passwordField == textField) {
		if (_signUpButton.hidden == NO) {
			[self signupButtonTapped:nil];
		}
		else
			[self signInTapped:nil];
	}

    return YES;
}


@end
