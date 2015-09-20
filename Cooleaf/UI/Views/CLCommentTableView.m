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
    // No separator lines
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)setHeaderContent:(CLEvent *)event image:(UIImage *)image {
    // Parent view containing extra padding
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 184.0f)];
    view.backgroundColor = [UIColor offWhite];
    
    // Background view for comment tableview header
    UIImageView *headerImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 160.0f)];
    headerImage.image = image;
    headerImage.contentMode = UIViewContentModeScaleAspectFill;
    
    // The name of the activity or item
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 90, 0, 0)];
    nameLabel.textAlignment = NSTextAlignmentLeft;
    nameLabel.text = [event name];
    nameLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
    nameLabel.backgroundColor = [UIColor clearColor];
    nameLabel.textColor = [UIColor clearColor];
    [nameLabel sizeToFit];
    nameLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    
    // Any content associated with activity or item
    UILabel *contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(00, 110.5, 250, 0)];
    contentLabel.textAlignment = NSTextAlignmentCenter;
    contentLabel.numberOfLines = 0;
    contentLabel.preferredMaxLayoutWidth = 10;
    contentLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
    contentLabel.backgroundColor = [UIColor clearColor];
    contentLabel.textColor = [UIColor clearColor];
    [contentLabel sizeToFit];
    contentLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    
    // Add views to parent view
    [view addSubview:headerImage];
    [view addSubview:nameLabel];
    [view addSubview:contentLabel];
    self.tableHeaderView = view;

}

@end
