//
//  NPAppDelegate.h
//  Cooleaf
//
//  Created by Bazyli Zygan on 14.12.2013.
//  Copyright (c) 2013 Nova Project. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MMDrawerController.h>
#import "CLBaseNotificationRegistry.h"

@interface NPAppDelegate : UIResponder <UIApplicationDelegate, UIAlertViewDelegate>

@property (nonatomic) CLBaseNotificationRegistry *registry;
@property (strong, nonatomic) UIWindow *window;
@property (weak, nonatomic) MMDrawerController *drawerController;

@end
