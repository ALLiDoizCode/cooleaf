//
//  CLGroupViewController.h
//  Cooleaf
//
//  Created by Jonathan Green on 9/3/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLGroupCell.h"

@interface CLGroupViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
