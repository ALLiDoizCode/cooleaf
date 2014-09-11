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
#import "UIFont+ApplicationFont.h"
#import "NPEventViewController.h"

#define kAppleLookupURLTemplate     @"http://itunes.apple.com/lookup?id=%@"
#define kAppStoreURLTemplate        @"https://itunes.apple.com/app/id"

@interface NPAppDelegate ()
{
    NSArray *_lastEvents;
    NSNumber *_searchedId;
}

@end

@implementation NPAppDelegate

- (void)checkNewVersionWithpdateBlock:(void(^)(NSString *newVersion))update
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *url = [NSString stringWithFormat:kAppleLookupURLTemplate, @"834329581"];
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
        if (data && [data length]>0) {
            id obj = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
            if (obj && [obj isKindOfClass:[NSDictionary class]]) {
                NSDictionary *dict = (NSDictionary *)obj;
                NSArray *array = dict[@"results"];
                if (array && [array count]>0) {
                    NSDictionary *app = array[0];
                    NSString *newVersion = app[@"version"];
                    [[NSUserDefaults standardUserDefaults] setObject:newVersion
                                                              forKey:@"kAppNewVersion"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    NSString *curVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
                    if (newVersion && curVersion && ![newVersion isEqualToString:curVersion]) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            if (update)
                                update(newVersion);
                        });
                    }
                }
            }
        }
    });
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
	[[UIApplication sharedApplication] registerForRemoteNotificationTypes:
     UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound];
    
    if ([[UIApplication sharedApplication] enabledRemoteNotificationTypes] == 0)
    {
        [NPCooleafClient sharedClient].notificationUDID = @"";
    }
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont mediumApplicationFontOfSize:18], NSFontAttributeName, nil]];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    self.window.backgroundColor = [UIColor whiteColor];
    
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[NPEventListViewController new]];
    
    [self.window makeKeyAndVisible];    
    [self.window.rootViewController presentViewController:[NPLoginViewController new] animated:NO completion:nil];
//    [self checkNewVersionWithpdateBlock:^(NSString *newVersion) {
//       UIAlertView *updateAlert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"New version available", nil)
//                                                             message:NSLocalizedString(@"New version of Cooleaf is available. Please update to continue using the application.", nil)
//                                                            delegate:self cancelButtonTitle:NSLocalizedString(@"Update", nil) otherButtonTitles:nil];
//        updateAlert.tag = 1001;
//        [updateAlert show];
//    }];
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
    [[NPCooleafClient sharedClient] checkEndpoints];
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    [self.window.rootViewController presentViewController:[NPLoginViewController new] animated:NO completion:nil];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Notification handling

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSString *strDeviceToken = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
	strDeviceToken = [strDeviceToken stringByReplacingOccurrencesOfString:@" " withString:@""];
    [NPCooleafClient sharedClient].notificationUDID = strDeviceToken;
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kNPCooleafClientRefreshNotification object:userInfo];
    if (userInfo[@"custom_data"])
    {
        [[NPCooleafClient sharedClient] fetchEventList:^(NSArray *events) {
            _lastEvents = events;
            _searchedId = userInfo[@"custom_data"][@"event_id"];
            UIAlertView *av = [[UIAlertView alloc] initWithTitle:nil message:userInfo[@"aps"][@"alert"]
                                                        delegate:self cancelButtonTitle:NSLocalizedString(@"OK", nil)
                                               otherButtonTitles:NSLocalizedString(@"Open", nil), nil];
            [av show];
            
        }];
    }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1001)
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[kAppStoreURLTemplate stringByAppendingString:@"834329581"]]];
    }
    else
    {
        if (buttonIndex == 1)
        {
            NSUInteger idx = 0;
            for (NSDictionary *e in _lastEvents)
            {
                if ([e[@"id"] compare:_searchedId] == NSOrderedSame)
                {
                    break;
                }
                idx++;
            }
            
            NPEventViewController *eC = [NPEventViewController new];
            eC.events = _lastEvents;
            eC.eventIdx = idx;
            [(UINavigationController *)self.window.rootViewController pushViewController:eC animated:YES];
        }
    }
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    [NPCooleafClient sharedClient].notificationUDID = @"";
}

@end
