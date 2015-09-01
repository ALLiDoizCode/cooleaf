//
//  CLHomeTableViewController.h
//  Cooleaf
//
//  Created by Haider Khan on 8/31/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IEventInteractor.h"
#import "CLEventPresenter.h"

@interface CLHomeTableViewController : UITableViewController <IEventInteractor, UITableViewDataSource, UITableViewDelegate>

@end
