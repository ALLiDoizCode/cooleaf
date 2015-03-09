//
//  NPRegistrationViewController.m
//  Cooleaf
//
//  Created by Curtis Jones on 2015.03.07.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "NPRegistrationViewController.h"
#import "NPCooleafClient.h"
#import "NPTag.h"
#import "NPTagGroup.h"
#import "UIFont+ApplicationFont.h"

@interface NPRegistrationViewController () <UITextFieldDelegate>
{
	NSString *_username;
	NSString *_password;
	
	/**
	 *
	 */
	UIView *_mainView;
	NSLayoutConstraint *_mainViewTopConstraint;
	UITextField *_currentTxt;
	CGRect _keyboardFrame;
	BOOL _keyboardIsVisible;
	
	/**
	 * Top bar
	 */
	UIView *_statusBarView;
	UIView *_topBarView;
	UIView *_backBtn;
	UIView *_nextBtn;
	
	/**
	 * Mid
	 */
	UILabel *_basicInfoLbl;
	UIImageView *_avatarImg;
	UILabel *_avatarLbl;
	
	/**
	 * Options
	 */
	UITextField *_nameTxt;
	UILabel *_locationLbl;
	UILabel *_departmentLbl;
	UILabel *_genderLbl;
	
	UIView *_modalView;
	UIActivityIndicatorView *_modalSpinner;
	
	NSMutableDictionary *_tagGroups;         // keyed on tag group name
}
@end

@implementation NPRegistrationViewController

#pragma mark - UIViewController

- (id)initWithUsername:(NSString *)username andPassword:(NSString *)password
{
	self = [super init];
	
	if (self) {
		_username = username;
		_password = password;
		_tagGroups = [[NSMutableDictionary alloc] init];
	}
	
	return self;
}

- (void)dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	// keyboard notifications
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(doNotificationKeyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(doNotificationKeyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
	
	// main view
	_mainView = [[UIView alloc] init];
	_mainView.translatesAutoresizingMaskIntoConstraints = FALSE;
	_mainView.backgroundColor = UIColor.whiteColor;
	_mainViewTopConstraint = [NSLayoutConstraint constraintWithItem:_mainView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1 constant:0];
	[self.view addSubview:_mainView];
	[self.view addConstraint:_mainViewTopConstraint];
	[self.view addConstraint:[NSLayoutConstraint constraintWithItem:_mainView attribute:NSLayoutAttributeLeft   relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft   multiplier:1 constant:0]];
	[self.view addConstraint:[NSLayoutConstraint constraintWithItem:_mainView attribute:NSLayoutAttributeWidth  relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth  multiplier:1 constant:0]];
	[self.view addConstraint:[NSLayoutConstraint constraintWithItem:_mainView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeHeight multiplier:1 constant:0]];
	
	// status bar view
	_statusBarView = [[UIView alloc] init];
	_statusBarView.translatesAutoresizingMaskIntoConstraints = FALSE;
	_statusBarView.backgroundColor = RGB(0x26, 0x8D, 0x86);
	[_mainView addSubview:_statusBarView];
	[_mainView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[view]|" options:0 metrics:nil views:@{@"view": _statusBarView}]];
	[_mainView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[view(20)]" options:0 metrics:nil views:@{@"view": _statusBarView}]];
	
	// top bar view
	_topBarView = [[UIView alloc] init];
	_topBarView.translatesAutoresizingMaskIntoConstraints = FALSE;
	_topBarView.backgroundColor = RGB(0x31, 0xCB, 0xC2);
	_topBarView.layer.shadowColor = UIColor.blackColor.CGColor;
	_topBarView.layer.shadowOpacity = 0.5;
	_topBarView.layer.shadowOffset = CGSizeMake(0, 1);
	_topBarView.layer.shadowRadius = 1;
	[_mainView addSubview:_topBarView];
	[_mainView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[view]|" options:0 metrics:nil views:@{@"view": _topBarView}]];
	[_mainView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-20-[view(50)]" options:0 metrics:nil views:@{@"view": _topBarView}]];
	
	// back button
	{
		// view
		_backBtn = [[UIView alloc] init];
		_backBtn.translatesAutoresizingMaskIntoConstraints = FALSE;
		[_topBarView addSubview:_backBtn];
		[_topBarView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[view(100)]" options:0 metrics:nil views:@{@"view": _backBtn}]];
		[_topBarView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[view]|" options:0 metrics:nil views:@{@"view": _backBtn}]];
		
		// left arrow
		UIImageView *backImg = [[UIImageView alloc] init];
		backImg.translatesAutoresizingMaskIntoConstraints = FALSE;
		backImg.image = [[UIImage imageNamed:@"AccessoryArrow"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
		backImg.tintColor = UIColor.whiteColor;
		backImg.transform = CGAffineTransformMakeRotation(M_PI);
		[_backBtn addSubview:backImg];
		[_backBtn addConstraint:[NSLayoutConstraint constraintWithItem:backImg attribute:NSLayoutAttributeLeft    relatedBy:NSLayoutRelationEqual toItem:_backBtn attribute:NSLayoutAttributeLeft           multiplier:1 constant:16]];
		[_backBtn addConstraint:[NSLayoutConstraint constraintWithItem:backImg attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_backBtn attribute:NSLayoutAttributeCenterY        multiplier:1 constant: 0]];
		[_backBtn addConstraint:[NSLayoutConstraint constraintWithItem:backImg attribute:NSLayoutAttributeWidth   relatedBy:NSLayoutRelationEqual toItem:nil      attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:13]];
		[_backBtn addConstraint:[NSLayoutConstraint constraintWithItem:backImg attribute:NSLayoutAttributeHeight  relatedBy:NSLayoutRelationEqual toItem:nil      attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:22]];
		
		// "sign up" label
		UILabel *backLbl = [[UILabel alloc] init];
		backLbl.translatesAutoresizingMaskIntoConstraints = FALSE;
		backLbl.font = [UIFont mediumApplicationFontOfSize:15];
		backLbl.textColor = UIColor.whiteColor;
		backLbl.text = @"SIGN UP";
		[_backBtn addSubview:backLbl];
		[_backBtn addConstraint:[NSLayoutConstraint constraintWithItem:backLbl attribute:NSLayoutAttributeLeft    relatedBy:NSLayoutRelationEqual toItem:backImg  attribute:NSLayoutAttributeRight   multiplier:1 constant:12]];
		[_backBtn addConstraint:[NSLayoutConstraint constraintWithItem:backLbl attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_backBtn attribute:NSLayoutAttributeCenterY multiplier:1 constant: 0]];
	}
	
	// next button
	{
		// view
		_nextBtn = [[UIView alloc] init];
		_nextBtn.translatesAutoresizingMaskIntoConstraints = FALSE;
		[_topBarView addSubview:_nextBtn];
		[_topBarView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[view(100)]|" options:0 metrics:nil views:@{@"view": _nextBtn}]];
		[_topBarView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[view]|" options:0 metrics:nil views:@{@"view": _nextBtn}]];
		
		// "next" label
		UILabel *nextLbl = [[UILabel alloc] init];
		nextLbl.translatesAutoresizingMaskIntoConstraints = FALSE;
		nextLbl.font = [UIFont mediumApplicationFontOfSize:16];
		nextLbl.textColor = UIColor.whiteColor;
		nextLbl.text = @"NEXT";
		[_nextBtn addSubview:nextLbl];
		[_nextBtn addConstraint:[NSLayoutConstraint constraintWithItem:nextLbl attribute:NSLayoutAttributeRight   relatedBy:NSLayoutRelationEqual toItem:_nextBtn attribute:NSLayoutAttributeRight   multiplier:1 constant:-16]];
		[_nextBtn addConstraint:[NSLayoutConstraint constraintWithItem:nextLbl attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_nextBtn attribute:NSLayoutAttributeCenterY multiplier:1 constant:  0]];
	}
	
	// "basic information" label
	_basicInfoLbl = [[UILabel alloc] init];
	_basicInfoLbl.translatesAutoresizingMaskIntoConstraints = FALSE;
	_basicInfoLbl.font = [UIFont mediumApplicationFontOfSize:15];
	_basicInfoLbl.textColor = RGB(0x31, 0xCB, 0xC2);
	_basicInfoLbl.text = @"BASIC INFORMATION";
	[_mainView addSubview:_basicInfoLbl];
	[_mainView addConstraint:[NSLayoutConstraint constraintWithItem:_basicInfoLbl attribute:NSLayoutAttributeTop  relatedBy:NSLayoutRelationEqual toItem:_topBarView attribute:NSLayoutAttributeBottom multiplier:1 constant:20]];
	[_mainView addConstraint:[NSLayoutConstraint constraintWithItem:_basicInfoLbl attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_mainView   attribute:NSLayoutAttributeLeft   multiplier:1 constant:20]];
	
	// avatar pic
	{
		// image view / button
		_avatarImg = [[UIImageView alloc] init];
		_avatarImg.translatesAutoresizingMaskIntoConstraints = FALSE;
		_avatarImg.image = [UIImage imageNamed:@"AvatarPlaceHolderMaleBig"];
		[_mainView addSubview:_avatarImg];
		[_mainView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[view(105)]"       options:0 metrics:nil views:@{@"view": _avatarImg}]];
		[_mainView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-155-[view(105)]" options:0 metrics:nil views:@{@"view": _avatarImg}]];
		[_mainView addConstraint:[NSLayoutConstraint constraintWithItem:_avatarImg attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:_mainView attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
		
		// avatar label
		_avatarLbl = [[UILabel alloc] init];
		_avatarLbl.translatesAutoresizingMaskIntoConstraints = FALSE;
		_avatarLbl.font = [UIFont mediumApplicationFontOfSize:9];
		_avatarLbl.textColor = RGB(0x99, 0x99, 0x99);
		_avatarLbl.text = @"Upload profile picture";
		[_mainView addSubview:_avatarLbl];
		[_mainView addConstraint:[NSLayoutConstraint constraintWithItem:_avatarLbl attribute:NSLayoutAttributeTop     relatedBy:NSLayoutRelationEqual toItem:_avatarImg attribute:NSLayoutAttributeBottom  multiplier:1 constant:10]];
		[_mainView addConstraint:[NSLayoutConstraint constraintWithItem:_avatarLbl attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:_avatarImg attribute:NSLayoutAttributeCenterX multiplier:1 constant: 0]];
	}
	
	// full name
	{
		// text field
		_nameTxt = [[UITextField alloc] init];
		_nameTxt.translatesAutoresizingMaskIntoConstraints = FALSE;
		_nameTxt.textColor = RGB(0x99, 0x99, 0x99);
		_nameTxt.delegate = self;
		_nameTxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Full Name" attributes:@{NSForegroundColorAttributeName:RGB(0x99, 0x99, 0x99)}];
		[_mainView addSubview:_nameTxt];
		[_mainView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[view]-20-|" options:0 metrics:nil views:@{@"view": _nameTxt}]];
		[_mainView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[topView]-85-[view(30)]" options:0 metrics:nil views:@{@"view": _nameTxt, @"topView": _avatarLbl}]];
		
		UIView *hrule = [[UIView alloc] init];
		hrule.translatesAutoresizingMaskIntoConstraints = FALSE;
		hrule.backgroundColor = RGB(0xD4, 0xD4, 0xD4);
		[_mainView addSubview:hrule];
		[_mainView addConstraint:[NSLayoutConstraint constraintWithItem:hrule attribute:NSLayoutAttributeLeft   relatedBy:NSLayoutRelationEqual toItem:_nameTxt attribute:NSLayoutAttributeLeft           multiplier:1 constant:-2]];
		[_mainView addConstraint:[NSLayoutConstraint constraintWithItem:hrule attribute:NSLayoutAttributeRight  relatedBy:NSLayoutRelationEqual toItem:_nameTxt attribute:NSLayoutAttributeRight          multiplier:1 constant: 2]];
		[_mainView addConstraint:[NSLayoutConstraint constraintWithItem:hrule attribute:NSLayoutAttributeTop    relatedBy:NSLayoutRelationEqual toItem:_nameTxt attribute:NSLayoutAttributeBottom         multiplier:1 constant: 0]];
		[_mainView addConstraint:[NSLayoutConstraint constraintWithItem:hrule attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil      attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant: 1]];
	}
	
	// location pop-up
	{
		// label
		_locationLbl = [[UILabel alloc] init];
		_locationLbl.translatesAutoresizingMaskIntoConstraints = FALSE;
		_locationLbl.font = [UIFont applicationFontOfSize:16];
		_locationLbl.textColor = RGB(0x99, 0x99, 0x99);
		_locationLbl.text = @"Location";
		[_mainView addSubview:_locationLbl];
		[_mainView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[view]-20-|" options:0 metrics:nil views:@{@"view": _locationLbl}]];
		[_mainView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[topView]-10-[view(30)]" options:0 metrics:nil views:@{@"view": _locationLbl, @"topView": _nameTxt}]];
		
		// arrow
		UIImageView *arrowImg = [[UIImageView alloc] init];
		arrowImg.translatesAutoresizingMaskIntoConstraints = FALSE;
		arrowImg.image = [[UIImage imageNamed:@"AccessoryArrow"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
		arrowImg.tintColor = RGB(0x99, 0x99, 0x99);
		arrowImg.transform = CGAffineTransformMakeRotation(M_PI_2);
		[_mainView addSubview:arrowImg];
		[_mainView addConstraint:[NSLayoutConstraint constraintWithItem:arrowImg attribute:NSLayoutAttributeRight   relatedBy:NSLayoutRelationEqual toItem:_locationLbl attribute:NSLayoutAttributeRight          multiplier:1 constant:-7]];
		[_mainView addConstraint:[NSLayoutConstraint constraintWithItem:arrowImg attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_locationLbl attribute:NSLayoutAttributeCenterY        multiplier:1 constant: 0]];
		[_mainView addConstraint:[NSLayoutConstraint constraintWithItem:arrowImg attribute:NSLayoutAttributeWidth   relatedBy:NSLayoutRelationEqual toItem:nil          attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant: 8]];
		[_mainView addConstraint:[NSLayoutConstraint constraintWithItem:arrowImg attribute:NSLayoutAttributeHeight  relatedBy:NSLayoutRelationEqual toItem:nil          attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:17]];
		
		// horizontal rule
		UIView *hrule = [[UIView alloc] init];
		hrule.translatesAutoresizingMaskIntoConstraints = FALSE;
		hrule.backgroundColor = RGB(0xD4, 0xD4, 0xD4);
		[_mainView addSubview:hrule];
		[_mainView addConstraint:[NSLayoutConstraint constraintWithItem:hrule attribute:NSLayoutAttributeLeft   relatedBy:NSLayoutRelationEqual toItem:_locationLbl attribute:NSLayoutAttributeLeft           multiplier:1 constant:-2]];
		[_mainView addConstraint:[NSLayoutConstraint constraintWithItem:hrule attribute:NSLayoutAttributeRight  relatedBy:NSLayoutRelationEqual toItem:_locationLbl attribute:NSLayoutAttributeRight          multiplier:1 constant: 2]];
		[_mainView addConstraint:[NSLayoutConstraint constraintWithItem:hrule attribute:NSLayoutAttributeTop    relatedBy:NSLayoutRelationEqual toItem:_locationLbl attribute:NSLayoutAttributeBottom         multiplier:1 constant: 0]];
		[_mainView addConstraint:[NSLayoutConstraint constraintWithItem:hrule attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil          attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant: 1]];
	}
	
	// department pop-up
	{
		// label
		_departmentLbl = [[UILabel alloc] init];
		_departmentLbl.translatesAutoresizingMaskIntoConstraints = FALSE;
		_departmentLbl.font = [UIFont applicationFontOfSize:16];
		_departmentLbl.textColor = RGB(0x99, 0x99, 0x99);
		_departmentLbl.text = @"Department";
		[_mainView addSubview:_departmentLbl];
		[_mainView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[view]-20-|" options:0 metrics:nil views:@{@"view": _departmentLbl}]];
		[_mainView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[topView]-10-[view(30)]" options:0 metrics:nil views:@{@"view": _departmentLbl, @"topView": _locationLbl}]];
		
		// arrow
		UIImageView *arrowImg = [[UIImageView alloc] init];
		arrowImg.translatesAutoresizingMaskIntoConstraints = FALSE;
		arrowImg.image = [[UIImage imageNamed:@"AccessoryArrow"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
		arrowImg.tintColor = RGB(0x99, 0x99, 0x99);
		arrowImg.transform = CGAffineTransformMakeRotation(M_PI_2);
		[_mainView addSubview:arrowImg];
		[_mainView addConstraint:[NSLayoutConstraint constraintWithItem:arrowImg attribute:NSLayoutAttributeRight   relatedBy:NSLayoutRelationEqual toItem:_departmentLbl attribute:NSLayoutAttributeRight          multiplier:1 constant:-7]];
		[_mainView addConstraint:[NSLayoutConstraint constraintWithItem:arrowImg attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_departmentLbl attribute:NSLayoutAttributeCenterY        multiplier:1 constant: 0]];
		[_mainView addConstraint:[NSLayoutConstraint constraintWithItem:arrowImg attribute:NSLayoutAttributeWidth   relatedBy:NSLayoutRelationEqual toItem:nil            attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant: 8]];
		[_mainView addConstraint:[NSLayoutConstraint constraintWithItem:arrowImg attribute:NSLayoutAttributeHeight  relatedBy:NSLayoutRelationEqual toItem:nil            attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:17]];
		
		// horizontal rule
		UIView *hrule = [[UIView alloc] init];
		hrule.translatesAutoresizingMaskIntoConstraints = FALSE;
		hrule.backgroundColor = RGB(0xD4, 0xD4, 0xD4);
		[_mainView addSubview:hrule];
		[_mainView addConstraint:[NSLayoutConstraint constraintWithItem:hrule attribute:NSLayoutAttributeLeft   relatedBy:NSLayoutRelationEqual toItem:_departmentLbl attribute:NSLayoutAttributeLeft           multiplier:1 constant:-2]];
		[_mainView addConstraint:[NSLayoutConstraint constraintWithItem:hrule attribute:NSLayoutAttributeRight  relatedBy:NSLayoutRelationEqual toItem:_departmentLbl attribute:NSLayoutAttributeRight          multiplier:1 constant: 2]];
		[_mainView addConstraint:[NSLayoutConstraint constraintWithItem:hrule attribute:NSLayoutAttributeTop    relatedBy:NSLayoutRelationEqual toItem:_departmentLbl attribute:NSLayoutAttributeBottom         multiplier:1 constant: 0]];
		[_mainView addConstraint:[NSLayoutConstraint constraintWithItem:hrule attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil            attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant: 1]];
	}
	
	// gender pop-up
	{
		// label
		_genderLbl = [[UILabel alloc] init];
		_genderLbl.translatesAutoresizingMaskIntoConstraints = FALSE;
		_genderLbl.font = [UIFont applicationFontOfSize:16];
		_genderLbl.textColor = RGB(0x99, 0x99, 0x99);
		_genderLbl.text = @"Gender";
		[_mainView addSubview:_genderLbl];
		[_mainView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-20-[view]-20-|" options:0 metrics:nil views:@{@"view": _genderLbl}]];
		[_mainView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[topView]-10-[view(30)]" options:0 metrics:nil views:@{@"view": _genderLbl, @"topView": _departmentLbl}]];
		
		// arrow
		UIImageView *arrowImg = [[UIImageView alloc] init];
		arrowImg.translatesAutoresizingMaskIntoConstraints = FALSE;
		arrowImg.image = [[UIImage imageNamed:@"AccessoryArrow"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
		arrowImg.tintColor = RGB(0x99, 0x99, 0x99);
		arrowImg.transform = CGAffineTransformMakeRotation(M_PI_2);
		[_mainView addSubview:arrowImg];
		[_mainView addConstraint:[NSLayoutConstraint constraintWithItem:arrowImg attribute:NSLayoutAttributeRight   relatedBy:NSLayoutRelationEqual toItem:_genderLbl attribute:NSLayoutAttributeRight          multiplier:1 constant:-7]];
		[_mainView addConstraint:[NSLayoutConstraint constraintWithItem:arrowImg attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_genderLbl attribute:NSLayoutAttributeCenterY        multiplier:1 constant: 0]];
		[_mainView addConstraint:[NSLayoutConstraint constraintWithItem:arrowImg attribute:NSLayoutAttributeWidth   relatedBy:NSLayoutRelationEqual toItem:nil        attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant: 8]];
		[_mainView addConstraint:[NSLayoutConstraint constraintWithItem:arrowImg attribute:NSLayoutAttributeHeight  relatedBy:NSLayoutRelationEqual toItem:nil        attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:17]];
		
		// horizontal rule
		UIView *hrule = [[UIView alloc] init];
		hrule.translatesAutoresizingMaskIntoConstraints = FALSE;
		hrule.backgroundColor = RGB(0xD4, 0xD4, 0xD4);
		[_mainView addSubview:hrule];
		[_mainView addConstraint:[NSLayoutConstraint constraintWithItem:hrule attribute:NSLayoutAttributeLeft   relatedBy:NSLayoutRelationEqual toItem:_genderLbl attribute:NSLayoutAttributeLeft           multiplier:1 constant:-2]];
		[_mainView addConstraint:[NSLayoutConstraint constraintWithItem:hrule attribute:NSLayoutAttributeRight  relatedBy:NSLayoutRelationEqual toItem:_genderLbl attribute:NSLayoutAttributeRight          multiplier:1 constant: 2]];
		[_mainView addConstraint:[NSLayoutConstraint constraintWithItem:hrule attribute:NSLayoutAttributeTop    relatedBy:NSLayoutRelationEqual toItem:_genderLbl attribute:NSLayoutAttributeBottom         multiplier:1 constant: 0]];
		[_mainView addConstraint:[NSLayoutConstraint constraintWithItem:hrule attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil        attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant: 1]];
	}
	
	// modal view - full screen
	_modalView = [[UIView alloc] init];
	_modalView.translatesAutoresizingMaskIntoConstraints = FALSE;
	_modalView.backgroundColor = RGBA(0., 0., 0., 0.9);
	_modalView.hidden = TRUE;
	[_mainView addSubview:_modalView];
	[_mainView addConstraint:[NSLayoutConstraint constraintWithItem:_modalView attribute:NSLayoutAttributeTop    relatedBy:NSLayoutRelationEqual toItem:_mainView attribute:NSLayoutAttributeTop    multiplier:1 constant:0]];
	[_mainView addConstraint:[NSLayoutConstraint constraintWithItem:_modalView attribute:NSLayoutAttributeLeft   relatedBy:NSLayoutRelationEqual toItem:_mainView attribute:NSLayoutAttributeLeft   multiplier:1 constant:0]];
	[_mainView addConstraint:[NSLayoutConstraint constraintWithItem:_modalView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_mainView attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
	[_mainView addConstraint:[NSLayoutConstraint constraintWithItem:_modalView attribute:NSLayoutAttributeRight  relatedBy:NSLayoutRelationEqual toItem:_mainView attribute:NSLayoutAttributeRight  multiplier:1 constant:0]];
	
	// modal spinner - centered in the screen
	_modalSpinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
	_modalSpinner.translatesAutoresizingMaskIntoConstraints = FALSE;
	[_modalView addSubview:_modalSpinner];
	[_modalView addConstraint:[NSLayoutConstraint constraintWithItem:_modalSpinner attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:_modalView attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
	[_modalView addConstraint:[NSLayoutConstraint constraintWithItem:_modalSpinner attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_modalView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
	
	[self modalShow];
	
	[[NPCooleafClient sharedClient] registerWithUsername:_username completion:^ (NSDictionary *object) {
		[(NSArray *)object[@"all_structure_tags"] enumerateObjectsUsingBlock:^ (NSDictionary *structure, NSUInteger index, BOOL *stop) {
			NPTagGroup *tagGroup = [[NPTagGroup alloc] initWithDictionary:structure];
			_tagGroups[tagGroup.name] = tagGroup;
		}];
		//DLog(@"%@", _tagGroups);
		[self modalHide];
	}];
}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
}





#pragma mark - Modal

- (void)modalShow
{
	_modalView.alpha = 0.0;
	_modalView.hidden = FALSE;
	
	[UIView animateWithDuration:0.25 animations:^ {
		_modalView.alpha = 1.0;
	}];
}

- (void)modalHide
{
	[UIView animateWithDuration:0.25 animations:^{
		_modalView.alpha = 0.0;
	} completion:^ (BOOL finished) {
		_modalView.hidden = TRUE;
	}];
}





#pragma mark - Notifications

#pragma mark - Notifications

- (void)doNotificationKeyboardWillShow:(NSNotification *)notification
{
	NSDictionary *keyboardInfo = notification.userInfo;
	CGRect keyboardFrameEnd = ((NSValue *)keyboardInfo[UIKeyboardFrameEndUserInfoKey]).CGRectValue;
	double animationDuration = ((NSNumber *)keyboardInfo[UIKeyboardAnimationDurationUserInfoKey]).doubleValue;
	
	_keyboardFrame = keyboardFrameEnd;
	_keyboardIsVisible = TRUE;
	
	if (nil == _currentTxt)
		return;
	
	CGFloat offset = CGRectGetMinY(_keyboardFrame) - 19.;
	
	if (CGRectGetMaxY(_currentTxt.frame) > offset) {
		[UIView animateWithDuration:animationDuration animations:^ {
			_mainViewTopConstraint.constant = -(CGRectGetMaxY(_currentTxt.frame) - offset);
			[self.view layoutIfNeeded];
		}];
	}
}

- (void)doNotificationKeyboardWillHide:(NSNotification *)notification
{
	NSDictionary *keyboardInfo = notification.userInfo;
	double animationDuration = ((NSNumber *)keyboardInfo[UIKeyboardAnimationDurationUserInfoKey]).doubleValue;
	
	_keyboardIsVisible = FALSE;
	
	[UIView animateWithDuration:animationDuration animations:^ {
		_mainViewTopConstraint.constant = 0;
		[self.view layoutIfNeeded];
	}];
}





#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	[textField resignFirstResponder];
	return TRUE;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
	_currentTxt = textField;
	
	if (FALSE == _keyboardIsVisible)
		return;
	
	CGFloat offset = CGRectGetMinY(_keyboardFrame) - 19.;
	
	if (CGRectGetMaxY(_currentTxt.frame) - _mainViewTopConstraint.constant > offset) {
		[UIView animateWithDuration:0.25 animations:^ {
			_mainViewTopConstraint.constant = -(CGRectGetMaxY(_currentTxt.frame) - offset);
			[self.view layoutIfNeeded];
		}];
	}
	else if (0 != _mainViewTopConstraint.constant) {
		[UIView animateWithDuration:0.25 animations:^ {
			_mainViewTopConstraint.constant = 0.;
			[self.view layoutIfNeeded];
		}];
	}
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
	_currentTxt = nil;
}

@end
