//
//  NPAttendeesCell.h
//  Cooleaf
//
//  Created by Bazyli Zygan on 06.01.2014.
//  Copyright (c) 2014 Nova Project. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NPAttendeesCell : UITableViewCell

@property (nonatomic, setter = setAttendees:) NSArray *attendees;
@property (nonatomic, assign) BOOL selfAttended;
@property (nonatomic, assign) NSUInteger attendeesCount;
@end
