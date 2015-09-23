//
//  CLNavigation.h
//  Cooleaf
//
//  Created by Jonathan Green on 9/3/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 *  Helper class for side menu navigation and other navigation points
 */
@interface CLNavigation : NSObject

- (void)homeController;
- (void)groupController;
- (void)peopleController;
- (void)myEventController;
- (void)groupPeopleController:(UINavigationController *)nav;
- (void)eventPeopleController:(UINavigationController *)nav;

@end
