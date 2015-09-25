//
//  CLGroupEventsController.h
//  Cooleaf
//
//  Created by Jonathan Green on 9/24/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CLGroupEventsController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableview;

@end
