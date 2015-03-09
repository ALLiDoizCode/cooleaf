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

@interface NPRegistrationViewController ()
{
	NSString *_username;
	NSString *_password;
	
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

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	// modal view - full screen
	_modalView = [[UIView alloc] init];
	_modalView.translatesAutoresizingMaskIntoConstraints = FALSE;
	_modalView.backgroundColor = RGBA(0., 0., 0., 0.9);
	_modalView.hidden = TRUE;
	[self.view addSubview:_modalView];
	[self.view addConstraint:[NSLayoutConstraint constraintWithItem:_modalView attribute:NSLayoutAttributeTop    relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop    multiplier:1.0 constant:0.0]];
	[self.view addConstraint:[NSLayoutConstraint constraintWithItem:_modalView attribute:NSLayoutAttributeLeft   relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft   multiplier:1.0 constant:0.0]];
	[self.view addConstraint:[NSLayoutConstraint constraintWithItem:_modalView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0]];
	[self.view addConstraint:[NSLayoutConstraint constraintWithItem:_modalView attribute:NSLayoutAttributeRight  relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight  multiplier:1.0 constant:0.0]];
	
	// modal spinner - centered in the screen
	_modalSpinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
	_modalSpinner.translatesAutoresizingMaskIntoConstraints = FALSE;
	[_modalView addSubview:_modalSpinner];
	[_modalView addConstraint:[NSLayoutConstraint constraintWithItem:_modalSpinner attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:_modalView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
	[_modalView addConstraint:[NSLayoutConstraint constraintWithItem:_modalSpinner attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:_modalView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0]];
	
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

@end
