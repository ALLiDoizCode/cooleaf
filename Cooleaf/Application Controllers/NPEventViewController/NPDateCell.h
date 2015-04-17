//
//  NPDateCell.h
//  Cooleaf
//
//  Created by Bazyli Zygan on 06.01.2014.
//  Copyright (c) 2014 Nova Project. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NPDateCell : UITableViewCell

@property (nonatomic, setter = setDateString:) NSString *dateString;
@property (nonatomic, assign) BOOL attending;
@property (nonatomic, copy) NSString *title;
@end
