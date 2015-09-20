//
//  CLCommentCell.m
//  Cooleaf
//
//  Created by Jonathan Green on 9/8/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "CLCommentCell.h"
#import "UIColor+CustomColors.h"

@implementation CLCommentCell

- (void)awakeFromNib {
    
    _cellImage.layer.cornerRadius = _cellImage.frame.size.height / 2;
    _cellImage.layer.masksToBounds = YES;
    _nameLabel.textColor = [UIColor darkGrayColor];
    _postLabel.textColor = [UIColor offBlack];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end