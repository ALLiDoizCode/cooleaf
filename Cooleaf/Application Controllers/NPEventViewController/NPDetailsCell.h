//
//  NPDetailsCell.h
//  Cooleaf
//
//  Created by Bazyli Zygan on 07.01.2014.
//  Copyright (c) 2014 Nova Project. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NPDetailsCell : UITableViewCell

@property (nonatomic, setter = setDetailsText:) NSString *detailsText;

+ (CGFloat)cellHeightForText:(NSString *)detailsText;

@end
