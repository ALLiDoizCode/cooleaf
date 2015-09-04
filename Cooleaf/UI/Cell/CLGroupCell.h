//
//  CLGroupCell.h
//  Cooleaf
//
//  Created by Jonathan Green on 9/4/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CLGroupCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *cellView;

@property (nonatomic) UIImageView *groupImageView;
@property (nonatomic) UILabel *labelName;

@end
