//
//  CLNavigation.m
//  Cooleaf
//
//  Created by Jonathan Green on 9/3/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "NPAppDelegate.h"
#import "CLNavigation.h"
#import "CLGroupViewController.h"
#import "CLPeopleViewController.h"

/**
 *  Classes used for navigation through side menu
 */
@implementation CLNavigation

- (void)homeController {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    UINavigationController *homeNavController = [storyboard instantiateViewControllerWithIdentifier:@"home"];
    NPAppDelegate *appDelegate = (NPAppDelegate *) [UIApplication sharedApplication].delegate;
    [[appDelegate drawerController] setCenterViewController:homeNavController];
    [[appDelegate drawerController] toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

- (void)groupController {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    CLGroupViewController *group = [storyboard instantiateViewControllerWithIdentifier:@"group"];
    UINavigationController *groupNav = [[UINavigationController alloc] initWithRootViewController:group];
    NPAppDelegate *appDelegate = (NPAppDelegate *) [UIApplication sharedApplication].delegate;
    [[appDelegate drawerController] setCenterViewController:groupNav];
    [[appDelegate drawerController] toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

- (void)peopleController {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    CLPeopleViewController *people = [storyboard instantiateViewControllerWithIdentifier:@"people"];
    UINavigationController *peopleNav = [[UINavigationController alloc] initWithRootViewController:people];
    NPAppDelegate *appDelegate = (NPAppDelegate *) [UIApplication sharedApplication].delegate;
    [[appDelegate drawerController] setCenterViewController:peopleNav];
    [[appDelegate drawerController] toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

@end
