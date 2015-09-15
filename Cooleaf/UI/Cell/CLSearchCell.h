//
//  CLSearchCell.h
//  Cooleaf
//
//  Created by Jonathan Green on 9/3/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CLSearchCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *mainLabel;
@property (weak, nonatomic) IBOutlet UILabel *subLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UIImageView *cellImage;

@end
