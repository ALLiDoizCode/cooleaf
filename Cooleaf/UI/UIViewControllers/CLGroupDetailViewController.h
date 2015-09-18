//
//  CLGroupDetailViewController.h
//  Cooleaf
//
//  Created by Jonathan Green on 9/4/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLDetailView.h"
#import "CLGroupPostViewcontroller.h"

@interface CLGroupDetailViewController : UIViewController <CLDetailViewDelegate, UITableViewDelegate, UITableViewDataSource, UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic) NSString *currentImagePath;
@property (nonatomic) NSString *currentName;
@property (strong, nonatomic) IBOutlet CLDetailView *detailView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIScrollView *detailScroll;

@end
