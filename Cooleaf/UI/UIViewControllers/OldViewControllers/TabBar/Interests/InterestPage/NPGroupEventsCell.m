//
//  NPGroupEventsCell.m
//  Cooleaf
//
//  Created by Dirk R on 3/23/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "NPGroupEventsCell.h"
#import "NPEventListViewController.h"

@interface NPGroupEventsCell ()
//{
//	NSNumber *_groupID;
//}

- (IBAction)groupEventsButtonPressed:(UIButton *)sender;

@end


@implementation NPGroupEventsCell

- (void)awakeFromNib {
    // Initialization code
	[_button2 addTarget:self action:@selector(doActionButton:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)groupEventsButtonPressed:(UIButton *)sender 		{
	NPEventListViewController *groupEventListController = [NPEventListViewController new];
	groupEventListController.title = @"Group Events";
	groupEventListController.refID = _groupID;
	groupEventListController.loadEventType = @"groupEvents";
	DLog(@"selected the groups row");
//	[self.navigationController pushViewController:groupEventListController animated:YES];
}

- (void)doActionButton:(id)sender
{
	NSLog(@"");
}

@end
