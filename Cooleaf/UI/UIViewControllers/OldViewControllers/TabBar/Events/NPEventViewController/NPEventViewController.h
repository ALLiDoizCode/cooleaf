//
//  NPEventViewController.h
//  Cooleaf
//
//  Created by Bazyli Zygan on 06.01.2014.
//  Copyright (c) 2014 Nova Project. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NPEventViewController : UIViewController <UIActionSheetDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) NSArray *events;
@property (nonatomic, assign) NSUInteger eventIdx;

@end
