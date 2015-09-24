//
//  CLGroupPostCell.h
//  Cooleaf
//
//  Created by Jonathan Green on 9/4/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CLGroupPostCell : UITableViewCell

@property (weak,nonatomic)IBOutlet UIImageView *userImage;
@property (weak,nonatomic)IBOutlet UILabel *labelCount;
@property (weak,nonatomic)IBOutlet UILabel *labelPostName;
@property (weak,nonatomic)IBOutlet UILabel *labelPostName2;
@property (weak,nonatomic)IBOutlet UILabel *labelPost;
@property (weak,nonatomic)IBOutlet UILabel *commentLabel;

@end
