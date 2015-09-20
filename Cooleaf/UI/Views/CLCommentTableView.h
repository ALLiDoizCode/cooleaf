//
//  CLCommentTableView.h
//  Cooleaf
//
//  Created by Jonathan Green on 9/8/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLEvent.h"

@interface CLCommentTableView : UITableView

- (void)setHeaderContent:(CLEvent *)event image:(UIImage *)image;

@end
