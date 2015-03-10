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

@interface NPRegistrationViewController () <UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource>
{
	NSString *_username;
	NSString *_password;
	
	/**
	 * Main
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
	UIView *_pickerView;
	UIView *_pickerBtn;
	UITextField *_nameTxt;
	UILabel *_locationLbl;
	UIPickerView *_locationPicker;
	UILabel *_departmentLbl;
	UIPickerView *_departmentPicker;
	UILabel *_genderLbl;
	UIPickerView *_genderPicker;
	UIPickerView *_currentPicker;
	
	/**
	 * Modal
	 */
	UIView *_modalView;
	UIActivityIndicatorView *_modalSpinner;
	
	/**
	 * Data
	 */
	NSMutableDictionary *_tagGroups;         // keyed on tag group name
	NPTagGroup *_locationTagGroup;
	NPTagGroup *_departmentTagGroup;
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
		_backBtn.userInteractionEnabled = TRUE;
		[_backBtn addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doActionBack:)]];
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
	
	// picker stuff
	{
		// the background for all of the pickers
		_pickerView = [[UIView alloc] init];
		_pickerView.translatesAutoresizingMaskIntoConstraints = FALSE;
		_pickerView.backgroundColor = RGBA(255, 255, 255, 0.9);
		_pickerView.hidden = TRUE;
		
		// view
		_pickerBtn = [[UIView alloc] init];
		_pickerBtn.translatesAutoresizingMaskIntoConstraints = FALSE;
		_pickerBtn.userInteractionEnabled = TRUE;
		_pickerBtn.hidden = TRUE;
		[_pickerBtn addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doActionPickerDone:)]];
		[_topBarView addSubview:_pickerBtn];
		[_topBarView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[view(100)]|" options:0 metrics:nil views:@{@"view": _pickerBtn}]];
		[_topBarView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[view(50)]|" options:0 metrics:nil views:@{@"view": _pickerBtn}]];
		
		// "done" label
		UILabel *doneLbl = [[UILabel alloc] init];
		doneLbl.translatesAutoresizingMaskIntoConstraints = FALSE;
		doneLbl.font = [UIFont mediumApplicationFontOfSize:16];
		doneLbl.textColor = UIColor.whiteColor;
		doneLbl.text = @"DONE";
		[_pickerBtn addSubview:doneLbl];
		[_pickerBtn addConstraint:[NSLayoutConstraint constraintWithItem:doneLbl attribute:NSLayoutAttributeRight   relatedBy:NSLayoutRelationEqual toItem:_pickerBtn attribute:NSLayoutAttributeRight   multiplier:1 constant:-16]];
		[_pickerBtn addConstraint:[NSLayoutConstraint constraintWithItem:doneLbl attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_pickerBtn attribute:NSLayoutAttributeCenterY multiplier:1 constant:  0]];
	}
	
	// location pop-up
	{
		// label
		_locationLbl = [[UILabel alloc] init];
		_locationLbl.translatesAutoresizingMaskIntoConstraints = FALSE;
		_locationLbl.font = [UIFont applicationFontOfSize:16];
		_locationLbl.textColor = RGB(0x99, 0x99, 0x99);
		_locationLbl.text = @"Location";
		_locationLbl.userInteractionEnabled = TRUE;
		[_locationLbl addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doActionLocation:)]];
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
		
		// picker view
		_locationPicker = [[UIPickerView alloc] init];
		_locationPicker.translatesAutoresizingMaskIntoConstraints = FALSE;
		_locationPicker.delegate = self;
		_locationPicker.dataSource = self;
		_locationPicker.hidden = TRUE;
		[_pickerView addSubview:_locationPicker];
		[_pickerView addConstraint:[NSLayoutConstraint constraintWithItem:_locationPicker attribute:NSLayoutAttributeLeft    relatedBy:NSLayoutRelationEqual toItem:_pickerView attribute:NSLayoutAttributeLeft    multiplier:1 constant:0]];
		[_pickerView addConstraint:[NSLayoutConstraint constraintWithItem:_locationPicker attribute:NSLayoutAttributeRight   relatedBy:NSLayoutRelationEqual toItem:_pickerView attribute:NSLayoutAttributeRight   multiplier:1 constant:0]];
		[_pickerView addConstraint:[NSLayoutConstraint constraintWithItem:_locationPicker attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_pickerView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
	}
	
	// department pop-up
	{
		// label
		_departmentLbl = [[UILabel alloc] init];
		_departmentLbl.translatesAutoresizingMaskIntoConstraints = FALSE;
		_departmentLbl.font = [UIFont applicationFontOfSize:16];
		_departmentLbl.textColor = RGB(0x99, 0x99, 0x99);
		_departmentLbl.text = @"Department";
		_departmentLbl.userInteractionEnabled = TRUE;
		[_departmentLbl addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doActionDepartment:)]];
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
		
		// picker view
		_departmentPicker = [[UIPickerView alloc] init];
		_departmentPicker.translatesAutoresizingMaskIntoConstraints = FALSE;
		_departmentPicker.delegate = self;
		_departmentPicker.dataSource = self;
		_departmentPicker.hidden = TRUE;
		[_pickerView addSubview:_departmentPicker];
		[_pickerView addConstraint:[NSLayoutConstraint constraintWithItem:_departmentPicker attribute:NSLayoutAttributeLeft    relatedBy:NSLayoutRelationEqual toItem:_pickerView attribute:NSLayoutAttributeLeft    multiplier:1 constant:0]];
		[_pickerView addConstraint:[NSLayoutConstraint constraintWithItem:_departmentPicker attribute:NSLayoutAttributeRight   relatedBy:NSLayoutRelationEqual toItem:_pickerView attribute:NSLayoutAttributeRight   multiplier:1 constant:0]];
		[_pickerView addConstraint:[NSLayoutConstraint constraintWithItem:_departmentPicker attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_pickerView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
	}
	
	// gender pop-up
	{
		// label
		_genderLbl = [[UILabel alloc] init];
		_genderLbl.translatesAutoresizingMaskIntoConstraints = FALSE;
		_genderLbl.font = [UIFont applicationFontOfSize:16];
		_genderLbl.textColor = RGB(0x99, 0x99, 0x99);
		_genderLbl.text = @"Gender";
		_genderLbl.userInteractionEnabled = TRUE;
		[_genderLbl addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doActionGender:)]];
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
		
		// picker view
		_genderPicker = [[UIPickerView alloc] init];
		_genderPicker.translatesAutoresizingMaskIntoConstraints = FALSE;
		_genderPicker.delegate = self;
		_genderPicker.dataSource = self;
		_genderPicker.hidden = TRUE;
		[_pickerView addSubview:_genderPicker];
		[_pickerView addConstraint:[NSLayoutConstraint constraintWithItem:_genderPicker attribute:NSLayoutAttributeLeft    relatedBy:NSLayoutRelationEqual toItem:_pickerView attribute:NSLayoutAttributeLeft    multiplier:1 constant:0]];
		[_pickerView addConstraint:[NSLayoutConstraint constraintWithItem:_genderPicker attribute:NSLayoutAttributeRight   relatedBy:NSLayoutRelationEqual toItem:_pickerView attribute:NSLayoutAttributeRight   multiplier:1 constant:0]];
		[_pickerView addConstraint:[NSLayoutConstraint constraintWithItem:_genderPicker attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_pickerView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
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
	
	// arrange the picker view here because we want it above everything else
	[_mainView addSubview:_pickerView];
	[_mainView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[view]|" options:0 metrics:nil views:@{@"view": _pickerView}]];
	[_mainView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[topView]-[view]|" options:0 metrics:nil views:@{@"view": _pickerView, @"topView": _topBarView}]];
	
	[self modalShow];
	
	[[NPCooleafClient sharedClient] registerWithUsername:_username completion:^ (NSDictionary *object) {
		[(NSArray *)object[@"all_structure_tags"] enumerateObjectsUsingBlock:^ (NSDictionary *structure, NSUInteger index, BOOL *stop) {
			NPTagGroup *tagGroup = [[NPTagGroup alloc] initWithDictionary:structure];
			_tagGroups[tagGroup.name] = tagGroup;
		}];
		_locationTagGroup = _tagGroups[@"Location"];
		_departmentTagGroup = _tagGroups[@"Department"];
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





#pragma mark - Actions

- (void)doActionBack:(id)sender
{
	DLog(@"");
	[self dismissViewControllerAnimated:TRUE completion:nil];
}

- (void)doActionNext:(id)sender
{
	DLog(@"");
	
}

- (void)doActionPickerDone:(UITapGestureRecognizer *)gr
{
	DLog(@"");
	
	_pickerView.hidden = TRUE;
	_pickerBtn.hidden = TRUE;
	_backBtn.hidden = FALSE;
	_nextBtn.hidden = FALSE;
	
	if (_currentPicker == _locationPicker) {
		_locationPicker.hidden = TRUE;
		_locationLbl.text = ((NPTag *)_locationTagGroup.tags[[_locationPicker selectedRowInComponent:0]]).name;
	}
	else if (_currentPicker == _departmentPicker) {
		_departmentPicker.hidden = TRUE;
		_departmentLbl.text = ((NPTag *)_departmentTagGroup.tags[[_departmentPicker selectedRowInComponent:0]]).name;
	}
	else if (_currentPicker == _genderPicker) {
		_genderPicker.hidden = TRUE;
		_genderLbl.text = [self pickerView:_genderPicker titleForRow:[_genderPicker selectedRowInComponent:0] forComponent:0];
	}
}

- (void)doActionLocation:(UITapGestureRecognizer *)gr
{
	[self showPicker:_locationPicker];
}

- (void)doActionDepartment:(UITapGestureRecognizer *)gr
{
	[self showPicker:_departmentPicker];
}

- (void)doActionGender:(UITapGestureRecognizer *)gr
{
	[self showPicker:_genderPicker];
}

- (void)showPicker:(UIPickerView *)pickerView
{
	_currentPicker = pickerView;
	[_currentPicker reloadAllComponents];
	_pickerView.hidden = FALSE;
	_pickerView.alpha = 0;
	_pickerBtn.hidden = FALSE;
	_currentPicker.hidden = FALSE;
	_backBtn.hidden = TRUE;
	_nextBtn.hidden = TRUE;
	_pickerBtn.hidden = FALSE;
	[UIView animateWithDuration:0.25 animations:^{
		_pickerView.alpha = 1;
	}];
}





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





#pragma mark - UIPickerViewDelegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
	if (pickerView == _locationPicker)
		return ((NPTag *)_locationTagGroup.tags[row]).name;
	else if (pickerView == _departmentPicker)
		return ((NPTag *)_departmentTagGroup.tags[row]).name;
	else if (pickerView == _genderPicker) {
		if (row == 0)
			return @"Male";
		else
			return @"Female";
	}
	else
		return @"";
}





#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
	if (pickerView == _locationPicker)
		return _locationTagGroup.tags.count;
	else if (pickerView == _departmentPicker)
		return _departmentTagGroup.tags.count;
	else if (pickerView == _genderPicker)
		return 2;
	else
		return 0;
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
