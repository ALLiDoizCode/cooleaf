//
//  NPEventSeriesDateCell.h
//  Cooleaf
//
//  Created by Dirk R on 4/5/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NPSeriesEvent;

@interface NPEventSeriesDateCell : UITableViewCell

@property (readwrite, assign, nonatomic) NPSeriesEvent *event;
@property (readwrite, assign, nonatomic) NSNumber *eventID;

@end
