//
//  NPTagGroupsView.h
//  Cooleaf
//
//  Created by Dirk R on 5/11/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import <UIKit/UIKit.h>
IB_DESIGNABLE

@interface NPTagGroupsView : UIView
@property (weak, nonatomic) IBOutlet UILabel *tagGroupNameLabel;
@property (strong, nonatomic) NSArray *tagsArray;

@end
