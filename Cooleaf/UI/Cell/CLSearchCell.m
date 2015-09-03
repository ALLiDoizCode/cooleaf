//
//  CLSearchCell.m
//  Cooleaf
//
//  Created by Jonathan Green on 9/3/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "CLSearchCell.h"

@implementation CLSearchCell

- (void)awakeFromNib {
    // Initialization code
    _cellImage.layer.cornerRadius = _cellImage.frame.size.height/2;
    _cellImage.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
