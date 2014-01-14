//
//  NPAttendeesViewController.h
//  Cooleaf
//
//  Created by Bazyli Zygan on 07.01.2014.
//  Copyright (c) 2014 Nova Project. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NPAttendeesViewController : UIViewController <UITableViewDataSource>

@property (nonatomic, retain) NSNumber *eventId;
@property (nonatomic, assign) NSUInteger attendeesCount;
@end
