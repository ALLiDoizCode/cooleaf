//
//  CLGroupDetailCollectionCell.m
//  Cooleaf
//
//  Created by Jonathan Green on 9/16/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "CLGroupDetailCollectionCell.h"

@implementation CLGroupDetailCollectionCell

-(void)awakeFromNib {
    // Make a rounded member photo
    _memberImage.contentMode = UIViewContentModeScaleAspectFill;
    _memberImage.layer.cornerRadius = _memberImage.frame.size.height / 2;
    _memberImage.layer.masksToBounds = YES;
}

@end
