//
//  MainViewController.h
//  Cooleaf
//
//  Created by Dirk R on 2/28/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NPHomeViewController;
@class NPEventListViewController;
//@class NPChallengesViewController;
@class NPInterestsViewController;
@class NPProfileViewController;

@interface MainViewController : UITabBarController

@property (readonly, nonatomic) NPHomeViewController *homeViewController;
@property (readonly, nonatomic) NPEventListViewController *eventListViewController;
//@property (readonly, nonatomic) NPChallengesViewController *challengesViewController;
@property (readonly, nonatomic) NPInterestsViewController *interestsViewController;
@property (readonly, nonatomic) NPProfileViewController *profileViewController;


@end
