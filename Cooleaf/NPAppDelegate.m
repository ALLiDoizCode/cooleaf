//
//  NPAppDelegate.m
//  Cooleaf
//
//  Created by Bazyli Zygan on 14.12.2013.
//  Copyright (c) 2013 Nova Project. All rights reserved.
//

#import <SSKeychain/SSKeychain.h>

#import "NPAppDelegate.h"
#import "NPCooleafClient.h"
#import "NPEventListViewController.h"
#import "NPLoginViewController.h"

@implementation NPAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont applicationFontOfSize:18], NSFontAttributeName, nil]];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    self.window.backgroundColor = [UIColor whiteColor];
    
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[NPEventListViewController new]];
    
    [self.window makeKeyAndVisible];    
    NSString *username = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"];
    if (!username || ![SSKeychain passwordForService:@"cooleaf" account:username])
    {
//        dispatch_async(dispatch_get_main_queue(), ^{
            [self.window.rootViewController presentViewController:[[UINavigationController alloc] initWithRootViewController:[NPLoginViewController new]] animated:NO completion:nil];
//        });
    }

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
