//
//  NPInterestViewController.h
//  Cooleaf
//
//  Created by Dirk R on 3/15/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NPInterestViewController : UIViewController<UIActionSheetDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) NSArray *events;
@property (nonatomic, assign) NSUInteger eventIdx;


@end
