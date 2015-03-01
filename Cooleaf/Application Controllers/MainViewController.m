//
//  MainViewController.m
//  Cooleaf
//
//  Created by Dirk R on 2/28/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "MainViewController.h"
#import "NPHomeViewController.h"
#import "NPEventListViewController.h"
#import "NPChallengesViewController.h"
#import "NPInterestsViewController.h"
#import "NPProfileViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];

	self.tabBar.barStyle = UIBarStyleDefault;
	self.tabBar.tintColor = [UIColor colorWithRed:78.0/255.0 green:205.0/255.0 blue:196.0/255 alpha:1.0];
	self.tabBar.translucent = TRUE;
	
	[[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:0.0/255.0 green:0.0/255.0 blue:0.0/255 alpha:1.0]} forState:UIControlStateNormal];
	[[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor colorWithRed:78.0/255.0 green:205.0/255.0 blue:196.0/255 alpha:1.0]} forState:UIControlStateSelected];

	_homeViewController = [[NPHomeViewController alloc] init];
	_eventListViewController = [[NPEventListViewController alloc] init];
	_challengesViewController = [[NPChallengesViewController alloc] init];
	_interestsViewController = [[NPInterestsViewController alloc] init];
	_profileViewController = [[NPProfileViewController alloc] init];
	
	(void)_homeViewController.view;
	(void)_eventListViewController.view;
	(void)_challengesViewController.view;
	(void)_interestsViewController.view;
	(void)_profileViewController.view;
	
	
	UINavigationController *homeNavController = [[UINavigationController alloc] initWithRootViewController:_homeViewController];
	homeNavController.navigationBarHidden = TRUE;
	homeNavController.toolbarHidden = TRUE;
	
	UINavigationController *eventsNavController = [[UINavigationController alloc] initWithRootViewController:_eventListViewController];
	eventsNavController.navigationBarHidden = TRUE;
	eventsNavController.toolbarHidden = TRUE;
	
	UINavigationController *challengesNavController = [[UINavigationController alloc] initWithRootViewController:_challengesViewController];
	challengesNavController.navigationBarHidden = TRUE;
	challengesNavController.toolbarHidden = TRUE;
	
	UINavigationController *interestsNavController = [[UINavigationController alloc] initWithRootViewController:_interestsViewController];
	interestsNavController.navigationBarHidden = TRUE;
	interestsNavController.toolbarHidden = TRUE;
	
	UINavigationController *profileNavController = [[UINavigationController alloc] initWithRootViewController:_profileViewController];
	profileNavController.navigationBarHidden = TRUE;
	profileNavController.toolbarHidden = TRUE;

	
	[self setViewControllers:@[homeNavController, eventsNavController, challengesNavController, interestsNavController, profileNavController]];
	
	
	
	
	
	
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
