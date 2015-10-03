//
//  NPMembersViewController.h
//  Cooleaf
//
//  Created by Dirk R on 3/28/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NPMembersViewController : UIViewController <UITableViewDataSource>

@property (nonatomic, retain) NSNumber *eventId;
@property (nonatomic, assign) NSUInteger attendeesCount;
@end
