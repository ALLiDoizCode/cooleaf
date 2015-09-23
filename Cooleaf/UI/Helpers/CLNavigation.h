//
//  CLNavigation.h
//  Cooleaf
//
//  Created by Jonathan Green on 9/3/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CLEvent.h"
#import "CLInterest.h"

/**
 *  Helper class for side menu navigation and other navigation points
 */
@interface CLNavigation : NSObject

- (void)homeController;
- (void)groupController;
- (void)peopleController;
- (void)myEventController;
- (void)interestPeopleController:(UINavigationController *)nav interest:(CLInterest *)interest;
- (void)eventPeopleController:(UINavigationController *)nav event:(CLEvent *)event;

@end
