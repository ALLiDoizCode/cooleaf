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

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // Setup attachment imageview
    self.imageView.layer.masksToBounds = YES;
    self.imageView.layer.cornerRadius = self.imageView.frame.size.height / 2;
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
}

- (void)awakeFromNib {
    
    // Setup the user imageview
    _cellImage.layer.cornerRadius = _cellImage.frame.size.height / 2;
    _cellImage.layer.masksToBounds = YES;
    
    // Setup name and post label views
    _nameLabel.textColor = [UIColor darkGrayColor];
    _postLabel.textColor = [UIColor offBlack];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
