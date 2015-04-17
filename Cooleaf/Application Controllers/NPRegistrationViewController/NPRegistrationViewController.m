//
//  NPRegistrationViewController.m
//  Cooleaf
//
//  Created by Curtis Jones on 2015.03.07.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "NPRegistrationViewController.h"
#import "NPInterestsViewController2.h"
#import "NPCooleafClient.h"
#import "NPTag.h"
#import "NPTagGroup.h"
#import "UIFont+ApplicationFont.h"

@class NPRegistrationPicker;

@interface NPRegistrationViewController (PrivateMethods)
- (void)showPicker:(NPRegistrationPicker *)picker;
@end





@interface NPRegistrationPicker : NSObject <UIPickerViewDelegate, UIPickerViewDataSource>
{
@public
	__unsafe_unretained NPRegistrationViewController *_parent;
	NSString *_title;
	NSArray *_options;
	UILabel *_label;
	UIPickerView *_picker;
	NSInteger _index;
	NSArray *_topConstraints;
}
@end

@implementation NPRegistrationPicker

#pragma mark - Structors

- (id)init
{
	self = [super init];
	
	if (self) {
		_index = -1;
	}
	
	return self;
}

#pragma mark - Accessors

- (NSString *)selectedValue
{
	if (_index < 0 || _index >= _options.count)
		return nil;
	else {
		NSObject *object = _options[_index];
		if ([object isKindOfClass:NPTag.class])
			return @(((NPTag *)object).objectId).stringValue;
		else if ([object isKindOfClass:NSString.class])
			return (NSString *)object;
		else
			return nil;
	}
}

- (void)setSelectedValue:(NSObject *)value
{
	NSInteger valueInt = 0;
	
	if (value == nil)
		return;
	else if ([value isKindOfClass:NSString.class])
		valueInt = ((NSString *)value).integerValue;
	else if ([value isKindOfClass:NSNumber.class])
		valueInt = ((NSNumber *)value).integerValue;
	
	[_options enumerateObjectsUsingBlock:^ (NSObject *object, NSUInteger index, BOOL *stop) {
		if ([object isKindOfClass:NPTag.class] && ((NPTag *)object).objectId == valueInt) {
			_index = index;
			_label.text = ((NPTag *)object).name;
			*stop = TRUE;
		}
		else if ([object isKindOfClass:NSString.class] && [(NSString *)object isEqualToString:(NSString *)value]) {
			_index = index;
			_label.text = (NSString *)value;
			*stop = TRUE;
		}
	}];
}

#pragma mark - Actions

- (void)doActionShowPicker:(id)sender
{
	if (_options.count != 0) {
		if (_index == -1) {
			_index = 0;
			_label.text = [self pickerView:_picker titleForRow:_index forComponent:0];
		}
		[_picker selectRow:_index inComponent:0 animated:FALSE];
	}
	
	[_parent showPicker:self];
}

#pragma mark - UIPickerViewDelegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
	NSObject *object = _options[row];
	
	if ([object isKindOfClass:NPTag.class])
		return ((NPTag *)object).name;
	else if ([object isKindOfClass:NSString.class])
		return (NSString *)object;
	else
		return @"";
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
	_index = row;
	_label.text = [self pickerView:pickerView titleForRow:row forComponent:component];
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
	return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
	return _options.count;
}

@end





@interface NPRegistrationViewController () <UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
	/**
	 * Data
	 */
	NSString *_username;
	NSString *_password;
	NSString *_token;
	
	/**
	 * Main
	 */
	UIView *_mainView;
	UIScrollView *_contentView;
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
	UIImagePickerController *_avatarController;
	
	/**
	 * Options
	 */
	UIView *_pickerView;
	UIView *_pickerBtn;
	UITextField *_nameTxt;
	NPRegistrationPicker *_currentPicker;
	NSMutableArray *_pickers;
	
	/**
	 * Modal
	 */
	UIView *_modalView;
	UIActivityIndicatorView *_modalSpinner;
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
		_pickers = [[NSMutableArray alloc] init];
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
	
	// top bar
	[self renderTopBar];
	
	// content view
	_contentView = [[UIScrollView alloc] init];
	_contentView.translatesAutoresizingMaskIntoConstraints = FALSE;
	_contentView.backgroundColor = UIColor.whiteColor;
	[_mainView addSubview:_contentView];
	[_mainView addConstraint:[NSLayoutConstraint constraintWithItem:_contentView attribute:NSLayoutAttributeTop    relatedBy:NSLayoutRelationEqual toItem:_topBarView attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
	[_mainView addConstraint:[NSLayoutConstraint constraintWithItem:_contentView attribute:NSLayoutAttributeLeft   relatedBy:NSLayoutRelationEqual toItem:_mainView   attribute:NSLayoutAttributeLeft   multiplier:1 constant:0]];
	[_mainView addConstraint:[NSLayoutConstraint constraintWithItem:_contentView attribute:NSLayoutAttributeRight  relatedBy:NSLayoutRelationEqual toItem:_mainView   attribute:NSLayoutAttributeRight  multiplier:1 constant:0]];
	[_mainView addConstraint:[NSLayoutConstraint constraintWithItem:_contentView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_mainView   attribute:NSLayoutAttributeBottom multiplier:1 constant:0]];
	
	// "basic information" label
	_basicInfoLbl = [[UILabel alloc] init];
	_basicInfoLbl.translatesAutoresizingMaskIntoConstraints = FALSE;
	_basicInfoLbl.font = [UIFont mediumApplicationFontOfSize:15];
	_basicInfoLbl.textColor = RGB(0x31, 0xCB, 0xC2);
	_basicInfoLbl.text = @"BASIC INFORMATION";
	[_contentView addSubview:_basicInfoLbl];
	[_contentView addConstraint:[NSLayoutConstraint constraintWithItem:_basicInfoLbl attribute:NSLayoutAttributeTop  relatedBy:NSLayoutRelationEqual toItem:_contentView attribute:NSLayoutAttributeTop  multiplier:1 constant:20]];
	[_contentView addConstraint:[NSLayoutConstraint constraintWithItem:_basicInfoLbl attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_contentView attribute:NSLayoutAttributeLeft multiplier:1 constant:20]];
	
	// avatar pic
	{
		// image view / button
		_avatarImg = [[UIImageView alloc] init];
		_avatarImg.translatesAutoresizingMaskIntoConstraints = FALSE;
		_avatarImg.image = [UIImage imageNamed:@"AvatarPlaceHolderMaleBig"];
		_avatarImg.layer.masksToBounds = TRUE;
		_avatarImg.layer.cornerRadius = 50;
		_avatarImg.userInteractionEnabled = TRUE;
		[_avatarImg addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doActionPicture:)]];
		[_contentView addSubview:_avatarImg];
		[_contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[view(100)]"       options:0 metrics:nil views:@{@"view": _avatarImg}]];
		[_contentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-85-[view(100)]" options:0 metrics:nil views:@{@"view": _avatarImg}]];
		[_contentView addConstraint:[NSLayoutConstraint constraintWithItem:_avatarImg attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:_contentView attribute:NSLayoutAttributeCenterX multiplier:1 constant:0]];
		
		// avatar label
		_avatarLbl = [[UILabel alloc] init];
		_avatarLbl.translatesAutoresizingMaskIntoConstraints = FALSE;
		_avatarLbl.font = [UIFont mediumApplicationFontOfSize:9];
		_avatarLbl.textColor = RGB(0x99, 0x99, 0x99);
		_avatarLbl.text = @"Upload profile picture";
		_avatarLbl.userInteractionEnabled = TRUE;
		[_avatarLbl addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doActionPicture:)]];
		[_contentView addSubview:_avatarLbl];
		[_contentView addConstraint:[NSLayoutConstraint constraintWithItem:_avatarLbl attribute:NSLayoutAttributeTop     relatedBy:NSLayoutRelationEqual toItem:_avatarImg attribute:NSLayoutAttributeBottom  multiplier:1 constant:10]];
		[_contentView addConstraint:[NSLayoutConstraint constraintWithItem:_avatarLbl attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:_avatarImg attribute:NSLayoutAttributeCenterX multiplier:1 constant: 0]];
	}
	
	// full name
	{
		// text field
		_nameTxt = [[UITextField alloc] init];
		_nameTxt.translatesAutoresizingMaskIntoConstraints = FALSE;
		_nameTxt.textColor = RGB(0x99, 0x99, 0x99);
		_nameTxt.delegate = self;
		_nameTxt.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Full Name" attributes:@{NSForegroundColorAttributeName:RGB(0x99, 0x99, 0x99)}];
		[_contentView addSubview:_nameTxt];
		[_mainView addConstraint:[NSLayoutConstraint constraintWithItem:_nameTxt attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_mainView attribute:NSLayoutAttributeLeft multiplier:1 constant:20]];
		[_mainView addConstraint:[NSLayoutConstraint constraintWithItem:_nameTxt attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:_mainView attribute:NSLayoutAttributeRight multiplier:1 constant:-20]];
		[_mainView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[topView]-85-[view(30)]" options:0 metrics:nil views:@{@"view": _nameTxt, @"topView": _avatarLbl}]];
		
		UIView *hrule = [[UIView alloc] init];
		hrule.translatesAutoresizingMaskIntoConstraints = FALSE;
		hrule.backgroundColor = RGB(0xD4, 0xD4, 0xD4);
		[_contentView addSubview:hrule];
		[_contentView addConstraint:[NSLayoutConstraint constraintWithItem:hrule attribute:NSLayoutAttributeLeft   relatedBy:NSLayoutRelationEqual toItem:_nameTxt attribute:NSLayoutAttributeLeft           multiplier:1 constant:-2]];
		[_contentView addConstraint:[NSLayoutConstraint constraintWithItem:hrule attribute:NSLayoutAttributeRight  relatedBy:NSLayoutRelationEqual toItem:_nameTxt attribute:NSLayoutAttributeRight          multiplier:1 constant: 2]];
		[_contentView addConstraint:[NSLayoutConstraint constraintWithItem:hrule attribute:NSLayoutAttributeTop    relatedBy:NSLayoutRelationEqual toItem:_nameTxt attribute:NSLayoutAttributeBottom         multiplier:1 constant: 0]];
		[_contentView addConstraint:[NSLayoutConstraint constraintWithItem:hrule attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil      attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant: 1]];
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
	
	[[NPCooleafClient sharedClient] registerWithUsername:_username completion:^ (NSString *token, NSDictionary *tagGroups, NSDictionary *presets) {
		DLog(@"token = %@", token);
		DLog(@"tags = %@", tagGroups);
		DLog(@"presets = %@", presets);
		
		[self modalHide];
		
		if (token != nil && tagGroups != nil) {
			_token = token;
			
			NPTagGroup *locationTagGroup = tagGroups[@"Location"];
			NPTagGroup *departmentTagGroup = tagGroups[@"Department"];
			
			[self addPickerWithTitle:@"Location"   tags:locationTagGroup.tags   afterPicker:nil defaultValue:((NSArray *)presets[@(locationTagGroup.objectId).stringValue]).firstObject];
			[self addPickerWithTitle:@"Department" tags:departmentTagGroup.tags afterPicker:nil defaultValue:((NSArray *)presets[@(departmentTagGroup.objectId).stringValue]).firstObject];
			[self addPickerWithTitle:@"Gender"     tags:@[@"Male", @"Female"]   afterPicker:nil defaultValue:presets[@"Gender"]];
			
			_nameTxt.text = presets[@"Full Name"];
			
			[_contentView addConstraint:[NSLayoutConstraint constraintWithItem:((NPRegistrationPicker *)_pickers.lastObject)->_label attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:_contentView attribute:NSLayoutAttributeBottom multiplier:1 constant:-20]];
		}
		else {
			[[[UIAlertView alloc] initWithTitle:@"Registration Failed" message:@"Is this username already active?" delegate:nil cancelButtonTitle:@"Sorry" otherButtonTitles:nil] show];
			[self.navigationController popViewControllerAnimated:TRUE];
		}
	}];
}

- (void)viewWillAppear:(BOOL)animated
{
	[self.navigationController setNavigationBarHidden:TRUE];
}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
}

/**
 * This is the top bar of the view, with the "back" and "next" buttons.
 *
 */
- (void)renderTopBar
{
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
		_nextBtn.userInteractionEnabled = TRUE;
		[_nextBtn addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doActionNext:)]];
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
}

/**
 * If you're adding an additional instance of an existing picker, leave title and tags nil and we'll
 * copy those values from the existing picker.
 *
 */
- (void)addPickerWithTitle:(NSString *)title tags:(NSArray *)tags afterPicker:(NPRegistrationPicker *)existingPicker defaultValue:(NSString *)defaultValue
{
	NPRegistrationPicker *picker = [[NPRegistrationPicker alloc] init];
	picker->_parent = self;
	picker->_title = title != nil ? title : existingPicker->_title;
	picker->_options = tags != nil ? tags : existingPicker->_options;
	
	UIView *topView = nil;
	
	// position this new picker below the "existingPicker" (if one is given), or after the last
	// picker (if any), or if this is the first picker, position it below the "name" label.
	if (existingPicker != nil)
		topView = existingPicker->_label;
	else if (_pickers.count != 0)
		topView = ((NPRegistrationPicker *)_pickers.lastObject)->_label;
	else
		topView = _nameTxt;
	
	// label
	picker->_label = [[UILabel alloc] init];
	picker->_label.translatesAutoresizingMaskIntoConstraints = FALSE;
	picker->_label.font = [UIFont applicationFontOfSize:16];
	picker->_label.textColor = RGB(0x99, 0x99, 0x99);
	picker->_label.text = picker->_title;
	picker->_label.userInteractionEnabled = TRUE;
	[picker->_label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:picker action:@selector(doActionShowPicker:)]];
	picker->_topConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[topView]-10-[view(30)]" options:0 metrics:nil views:@{@"view": picker->_label, @"topView": topView}];
	[_contentView addSubview:picker->_label];
	[_mainView addConstraint:[NSLayoutConstraint constraintWithItem:picker->_label attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:_mainView attribute:NSLayoutAttributeLeft multiplier:1 constant:20]];
	[_mainView addConstraint:[NSLayoutConstraint constraintWithItem:picker->_label attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:_mainView attribute:NSLayoutAttributeRight multiplier:1 constant:-20]];
	[_contentView addConstraints:picker->_topConstraints];
	
	// arrow
	UIImageView *arrowImg = [[UIImageView alloc] init];
	arrowImg.translatesAutoresizingMaskIntoConstraints = FALSE;
	arrowImg.image = [[UIImage imageNamed:@"editPencil"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
	arrowImg.tintColor = RGB(0x99, 0x99, 0x99);
//	arrowImg.transform = CGAffineTransformMakeRotation(M_PI_2);
	[_contentView addSubview:arrowImg];
	[_mainView addConstraint:[NSLayoutConstraint constraintWithItem:arrowImg attribute:NSLayoutAttributeRight   relatedBy:NSLayoutRelationEqual toItem:picker->_label attribute:NSLayoutAttributeRight          multiplier:1 constant:-7]];
	[_mainView addConstraint:[NSLayoutConstraint constraintWithItem:arrowImg attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:picker->_label attribute:NSLayoutAttributeCenterY        multiplier:1 constant: 0]];
	[_mainView addConstraint:[NSLayoutConstraint constraintWithItem:arrowImg attribute:NSLayoutAttributeWidth   relatedBy:NSLayoutRelationEqual toItem:nil            attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant: 17]];
	[_mainView addConstraint:[NSLayoutConstraint constraintWithItem:arrowImg attribute:NSLayoutAttributeHeight  relatedBy:NSLayoutRelationEqual toItem:nil            attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:17]];
	
	// horizontal rule
	UIView *hrule = [[UIView alloc] init];
	hrule.translatesAutoresizingMaskIntoConstraints = FALSE;
	hrule.backgroundColor = RGB(0xD4, 0xD4, 0xD4);
	[_contentView addSubview:hrule];
	[_contentView addConstraint:[NSLayoutConstraint constraintWithItem:hrule attribute:NSLayoutAttributeLeft   relatedBy:NSLayoutRelationEqual toItem:picker->_label attribute:NSLayoutAttributeLeft           multiplier:1 constant:-2]];
	[_contentView addConstraint:[NSLayoutConstraint constraintWithItem:hrule attribute:NSLayoutAttributeRight  relatedBy:NSLayoutRelationEqual toItem:picker->_label attribute:NSLayoutAttributeRight          multiplier:1 constant: 2]];
	[_contentView addConstraint:[NSLayoutConstraint constraintWithItem:hrule attribute:NSLayoutAttributeTop    relatedBy:NSLayoutRelationEqual toItem:picker->_label attribute:NSLayoutAttributeBottom         multiplier:1 constant: 0]];
	[_contentView addConstraint:[NSLayoutConstraint constraintWithItem:hrule attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil            attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant: 1]];
	
	// picker view
	picker->_picker = [[UIPickerView alloc] init];
	picker->_picker.translatesAutoresizingMaskIntoConstraints = FALSE;
	picker->_picker.delegate = picker;
	picker->_picker.dataSource = picker;
	picker->_picker.hidden = TRUE;
	[_pickerView addSubview:picker->_picker];
	[_pickerView addConstraint:[NSLayoutConstraint constraintWithItem:picker->_picker attribute:NSLayoutAttributeLeft    relatedBy:NSLayoutRelationEqual toItem:_pickerView attribute:NSLayoutAttributeLeft    multiplier:1 constant:0]];
	[_pickerView addConstraint:[NSLayoutConstraint constraintWithItem:picker->_picker attribute:NSLayoutAttributeRight   relatedBy:NSLayoutRelationEqual toItem:_pickerView attribute:NSLayoutAttributeRight   multiplier:1 constant:0]];
	[_pickerView addConstraint:[NSLayoutConstraint constraintWithItem:picker->_picker attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_pickerView attribute:NSLayoutAttributeCenterY multiplier:1 constant:0]];
	
	// set the default value for the picker
	[picker setSelectedValue:defaultValue];
	
	// if we're adding this new picker as an additional instance of an existing picker, find the index
	// of the existing picker so that we can remove the layout constraint between it and the next
	// picker (if any), and then insert this new picker between them.
	if (existingPicker != nil) {
		__block NSInteger indexOfExistingPicker = -1;
		
		// find the index of the existing picker
		[_pickers enumerateObjectsUsingBlock:^ (NPRegistrationPicker *picker, NSUInteger index, BOOL *stop) {
			if (picker == existingPicker) {
				indexOfExistingPicker = index;
				*stop = TRUE;
			}
		}];
		
		// get the picker following the existing picker (if any) and remove its top constraints. replace
		// them with constraints to our new picker.
		if (indexOfExistingPicker < _pickers.count - 1) {
			NPRegistrationPicker *nextPicker = _pickers[indexOfExistingPicker + 1];
			[_contentView removeConstraints:nextPicker->_topConstraints];
			nextPicker->_topConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:[topView]-10-[view(30)]" options:0 metrics:nil views:@{@"view": nextPicker->_label, @"topView": picker->_label}];
			[_contentView addConstraints:nextPicker->_topConstraints];
		}
		
		[_pickers insertObject:picker atIndex:indexOfExistingPicker + 1];
	}
	else
		[_pickers addObject:picker];
}

- (NSString *)valueForPickerWithTitle:(NSString *)title
{
	__block NSString *value = nil;
	
	[_pickers enumerateObjectsUsingBlock:^ (NPRegistrationPicker *picker, NSUInteger index, BOOL *stop) {
		if ([picker->_title isEqualToString:title]) {
			value = [picker selectedValue];
			*stop = TRUE;
		}
	}];
	
	return value;
}

- (NSArray *)valuesForPickersWithTitle:(NSString *)title
{
	NSMutableArray *values = [[NSMutableArray alloc] init];
	
	[_pickers enumerateObjectsUsingBlock:^ (NPRegistrationPicker *picker, NSUInteger index, BOOL *stop) {
		if ([picker->_title isEqualToString:title]) {
			NSString *value = [picker selectedValue];
			if (value != nil)
				[values addObject:value];
		}
	}];
	
	return values;
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
	[self.navigationController popViewControllerAnimated:TRUE];
//[self dismissViewControllerAnimated:TRUE completion:nil];
}

- (void)doActionNext:(id)sender
{
	DLog(@"");
	
	NSMutableArray *tags = [[NSMutableArray alloc] init];
	
	[tags addObjectsFromArray:[self valuesForPickersWithTitle:@"Location"]];
	[tags addObjectsFromArray:[self valuesForPickersWithTitle:@"Department"]];
	
	NSString *gender = [self valueForPickerWithTitle:@"Gender"];
	
	[[NPCooleafClient sharedClient] updateRegistrationWithToken:_token name:_nameTxt.text gender:gender password:_password tags:tags completion:^ (BOOL success, NSString *error) {
		DLog(@"Done! success = %@", NSStringFromBool(success));
		
		if (success == FALSE) {
			[[[UIAlertView alloc] initWithTitle:@"Registration Failed." message:error delegate:nil cancelButtonTitle:@"Okay" otherButtonTitles:nil] show];
			[self dismissViewControllerAnimated:YES completion:nil];
			return;
		}
		
		[[NPCooleafClient sharedClient] loginWithUsername:[[NSUserDefaults standardUserDefaults] objectForKey:@"username"] password:_password completion:^(NSError *error) {
			
			NPInterestsViewController2 *interestsController = [[NPInterestsViewController2 alloc] init];
			interestsController.editModeOn = TRUE;
			interestsController.topBarEnabled = TRUE;
			interestsController.scrollEnabled = TRUE;
			[self.navigationController pushViewController:interestsController animated:TRUE];
			DLog(@"collectionView = %@", interestsController.collectionView);
			
			[[NPCooleafClient sharedClient] updatePictureWithImage:_avatarImg.image completion:^ (NSDictionary *unused) {
				DLog(@"Done! unused = %@", unused);
				
				if (unused != nil) {
					NSURL *avatarURL = [[NPCooleafClient sharedClient].baseURL URLByAppendingPathComponent:unused[@"versions"][@"big"]];
					DLog(@"avatarUrl = %@", avatarURL);
					[[NPCooleafClient sharedClient] fetchImage:avatarURL.absoluteString completion: ^ (NSString *imagePath, UIImage *image) {
						if (image && [imagePath isEqual:avatarURL.absoluteString])
							_avatarImg.image = image;
					}];
					
					NSDictionary *uD = [NPCooleafClient sharedClient].userData;
					[[NPCooleafClient sharedClient] updateProfileDataAllFields:_nameTxt.text email:nil password:nil tags:nil removed_picture:FALSE file_cache:unused[@"file_cache"] role_structure_required:uD[@"role"] profileDailyDigest:TRUE profileWeeklyDigest:TRUE profile:uD[@"profile"] completion:^{
						NSLog(@"Success");
					}];
				}
			}];
		}];
	}];
}

- (void)doActionPicture:(id)sender
{
	_avatarController = [[UIImagePickerController alloc] init];
	_avatarController.delegate = self;
	_avatarController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
	[self presentViewController:_avatarController animated:TRUE completion:nil];
}

- (void)doActionPictureCamera:(id)sender
{
	UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithTitle:@"Library" style:UIBarButtonItemStylePlain target:self action:@selector(doActionPictureLibrary:)];
	_avatarController.navigationBar.topItem.leftBarButtonItem = button;
	_avatarController.sourceType = UIImagePickerControllerSourceTypeCamera;
}

- (void)doActionPictureLibrary:(id)sender
{
	UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithTitle:@"Camera" style:UIBarButtonItemStylePlain target:self action:@selector(doActionPictureCamera:)];
	_avatarController.navigationBar.topItem.leftBarButtonItem = button;
	_avatarController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
}

- (void)doActionPickerDone:(UITapGestureRecognizer *)gr
{
	DLog(@"");
	
	_pickerView.hidden = TRUE;
	_pickerBtn.hidden = TRUE;
	_backBtn.hidden = FALSE;
	_nextBtn.hidden = FALSE;
	
	_currentPicker->_picker.hidden = TRUE;
	
	// don't add an additional picker for the "gender" picker
	if (FALSE == [_currentPicker->_title isEqualToString:@"Gender"]) {
		// TODO: only do this if there isn't already an unused existing picker
		[self addPickerWithTitle:nil tags:nil afterPicker:_currentPicker defaultValue:nil];
	}
}

- (void)showPicker:(NPRegistrationPicker *)picker
{
	_currentPicker = picker;
	[_currentPicker->_picker reloadAllComponents];
	_pickerView.hidden = FALSE;
	_pickerView.alpha = 0;
	_pickerBtn.hidden = FALSE;
	_currentPicker->_picker.hidden = FALSE;
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





#pragma mark - UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
	if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
		UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithTitle:@"Camera" style:UIBarButtonItemStylePlain target:self action:@selector(doActionPictureCamera:)];
		navigationController.navigationBar.topItem.leftBarButtonItem = button;
	}
}





#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
	DLog(@"%@", info);
	_avatarImg.image = info[UIImagePickerControllerOriginalImage];
	[_avatarController dismissViewControllerAnimated:TRUE completion:nil];
	_avatarController = nil;
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
	if (_avatarController.sourceType == UIImagePickerControllerSourceTypeCamera) {
		[self doActionPictureLibrary:picker];
	}
	else {
		[_avatarController dismissViewControllerAnimated:TRUE completion:nil];
		_avatarController = nil;
	}
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
