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
#import "CLHomeTableViewController.h"
#import "CLInterest.h"
#import "CLGroupEventsController.h"

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

- (void)myEventController {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    //Here I am creating a instance of CLHomeTableViewController pointing to theactual viewcontroller in stroyboard and making the the currentView property of CLHomeTableViewController equal the string "My Events"
    CLHomeTableViewController *myEvent = [storyboard instantiateViewControllerWithIdentifier:@"HomeTable"];
    myEvent.currentView = @"My Events";
    UINavigationController *myEventNav = [[UINavigationController alloc] initWithRootViewController:myEvent];
    NPAppDelegate *appDelegate = (NPAppDelegate *) [UIApplication sharedApplication].delegate;
    [[appDelegate drawerController] setCenterViewController:myEventNav];
    [[appDelegate drawerController] toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
    
}

- (void)groupEventsController:(UINavigationController *)nav {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    CLGroupEventsController *groupEvents = [storyboard instantiateViewControllerWithIdentifier:@"groupEvents"];
    [nav pushViewController:groupEvents animated:YES];
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

- (void)interestPeopleController:(UINavigationController *)nav interest:(CLInterest *)interest {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    CLPeopleViewController *people = [storyboard instantiateViewControllerWithIdentifier:@"people"];
    [people setCurrentView:@"Groups"];
    [people setInterest:interest];
    [nav pushViewController:people animated:YES];
}

- (void)eventPeopleController:(UINavigationController *)nav event:(CLEvent *)event {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    CLPeopleViewController *people = [storyboard instantiateViewControllerWithIdentifier:@"people"];
    [people setCurrentView:@"Events"];
    [people setEvent:event];
    [nav pushViewController:people animated:YES];
}

@end
