//
//  CLEventCollectionCell.m
//  Cooleaf
//
//  Created by Jonathan Green on 9/15/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "CLEventCollectionCell.h"

@implementation CLEventCollectionCell

-(void)awakeFromNib {
    
    _memberImage.layer.cornerRadius = _memberImage.frame.size.height/2;
    _memberImage.layer.masksToBounds = YES;
}

@end
