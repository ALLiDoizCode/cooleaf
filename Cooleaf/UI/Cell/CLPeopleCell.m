//
//  CLPeopleCell.m
//  Cooleaf
//
//  Created by Jonathan Green on 9/10/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "CLPeopleCell.h"
#import "LabelWidth.h"

@implementation CLPeopleCell

- (void)awakeFromNib {
    
    [LabelWidth labelWidth:_peopleLabel];
    [LabelWidth labelWidth:_positionLabel];
    _peopleImage.layer.cornerRadius = _peopleImage.frame.size.height/2;
    _peopleImage.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
