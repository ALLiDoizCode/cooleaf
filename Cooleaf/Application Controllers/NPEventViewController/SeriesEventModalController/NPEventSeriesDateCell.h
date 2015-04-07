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

@property (readwrite, strong, nonatomic) NPSeriesEvent *event;
@property (readwrite, strong, nonatomic) NSNumber *eventID;

@end
