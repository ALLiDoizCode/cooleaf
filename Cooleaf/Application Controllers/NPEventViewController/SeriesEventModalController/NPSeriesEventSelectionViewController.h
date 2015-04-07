//
//  NPSeriesEventSelectionViewController.h
//  Cooleaf
//
//  Created by Dirk R on 4/5/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NPSeriesEventSelectionViewController : UITableViewController

@property (nonatomic, readwrite, assign) NSNumber *eventID;
@property (nonatomic, readwrite, assign) NSNumber *seriesID;

@end
