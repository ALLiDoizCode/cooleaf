//
//  NPGroupEventsCell.h
//  Cooleaf
//
//  Created by Dirk R on 3/23/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NPGroupEventsCell : UITableViewCell

@property (nonatomic, assign) NSNumber* groupID;
@property (readwrite, assign, nonatomic) IBOutlet UIButton *button2;

@end
