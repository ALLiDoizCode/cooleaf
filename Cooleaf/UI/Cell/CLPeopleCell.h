//
//  CLPeopleCell.h
//  Cooleaf
//
//  Created by Jonathan Green on 9/10/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CLPeopleCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *peopleImage;
@property (weak, nonatomic) IBOutlet UILabel *peopleLabel;
@property (weak, nonatomic) IBOutlet UILabel *positionLabel;

@end
