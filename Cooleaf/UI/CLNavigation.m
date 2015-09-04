//
//  CLNavigation.m
//  Cooleaf
//
//  Created by Jonathan Green on 9/3/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "CLNavigation.h"

@implementation CLNavigation

- (void)homeController {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    
    UINavigationController *homeNavController = [storyboard instantiateViewControllerWithIdentifier:@"home"];
    
    NPAppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    
    [[appDelegate drawerController] setCenterViewController:homeNavController];
    [[appDelegate drawerController] toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
    
    
    //homeController
    
}

- (void)groupController {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    
    CLGroupViewController *group = [storyboard instantiateViewControllerWithIdentifier:@"group"];
    
    UINavigationController *groupNav = [[UINavigationController alloc] initWithRootViewController:group];
    
    NPAppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    
    [[appDelegate drawerController] setCenterViewController:groupNav];
    [[appDelegate drawerController] toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
    
    
    //groupController
    
}


@end
