//
//  CLGroupPostViewcontroller.h
//  Cooleaf
//
//  Created by Jonathan Green on 9/4/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLGroupPostCell.h"

@interface CLGroupPostViewcontroller : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
