//
//  LabelWidth.m
//  Cooleaf
//
//  Created by Jonathan Green on 9/16/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "LabelWidth.h"

@implementation LabelWidth

+(void)labelWidth:(UILabel *)theLabel {
    
    //use this for custom font
    //CGFloat width =  [theLabel.text sizeWithFont:[UIFont fontWithName:@"ChaparralPro-Bold" size:40 ]].width;
    
    //use this for system font
    CGFloat width =  [theLabel.text sizeWithFont:[UIFont systemFontOfSize:40 ]].width;
    
    theLabel.frame = CGRectMake(theLabel.frame.origin.x, theLabel.frame.origin.y, width, theLabel.frame.size.height);
    
    //point.x, point.y -> origin for label;
    //height -> your label height;
}

@end
