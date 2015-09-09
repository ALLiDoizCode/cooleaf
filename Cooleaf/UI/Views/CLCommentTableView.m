//
//  CLCommentTableView.m
//  Cooleaf
//
//  Created by Jonathan Green on 9/8/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "CLCommentTableView.h"
#import "UIColor+CustomColors.h"

@implementation CLCommentTableView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)awakeFromNib {
    
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    //self.rowHeight = UITableViewAutomaticDimension;
    //self.estimatedRowHeight = 400.0;
    
    
    
    self.tableHeaderView = ({
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 184.0f)];
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 160.0f)];
        bgView.backgroundColor = [UIColor UIColorFromRGB:0xF1F1F1];
        view.backgroundColor = [UIColor offWhite];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 10, 70, 70)];
        imageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        imageView.image = [UIImage imageNamed:@"TestImage"];
        imageView.layer.masksToBounds = YES;
        imageView.layer.cornerRadius = imageView.frame.size.height/2;
        imageView.layer.borderColor = [UIColor clearColor].CGColor;
        imageView.layer.borderWidth = 3.0f;
        imageView.layer.rasterizationScale = [UIScreen mainScreen].scale;
        imageView.layer.shouldRasterize = YES;
        imageView.clipsToBounds = YES;
        
        //Name
        UILabel *labelName = [[UILabel alloc] initWithFrame:CGRectMake(0, 90, 0, 0)];
        labelName.textAlignment = NSTextAlignmentLeft;
        labelName.text = @"Prem Bhatia";
        labelName.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
        labelName.backgroundColor = [UIColor clearColor];
        labelName.textColor = [UIColor offBlack];
        [labelName sizeToFit];
        labelName.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        
        //Post
        UILabel *labelPost = [[UILabel alloc] initWithFrame:CGRectMake(00, 110.5, 250, 0)];
        labelPost.textAlignment = NSTextAlignmentCenter;
        labelPost.numberOfLines = 0;
        labelPost.preferredMaxLayoutWidth = 10;
        labelPost.text = @"What is the next book that we will be reading?";
        labelPost.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
        labelPost.backgroundColor = [UIColor clearColor];
        labelPost.textColor = [UIColor offBlack];
        [labelPost sizeToFit];
        labelPost.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
        
        [view addSubview:bgView];
        [view addSubview:imageView];
        [view addSubview:labelName];
        [view addSubview:labelPost];
        view;
    });
    
}

@end
