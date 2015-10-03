//
//  NPMembersCell.h
//  Cooleaf
//
//  Created by Dirk R on 3/16/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NPMembersCell : UITableViewCell

@property (nonatomic, setter = setAttendees:) NSArray *attendees;
@property (nonatomic, assign) BOOL selfAttended;
@property (nonatomic, assign) NSUInteger attendeesCount;
@end
