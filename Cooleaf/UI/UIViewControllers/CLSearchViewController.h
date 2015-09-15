//
//  CLSearchViewController.h
//  Cooleaf
//
//  Created by Jonathan Green on 9/2/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLSearchCell.h"
#import "ISearchInteractor.h"

@interface CLSearchViewController : UIViewController <ISearchInteractor, UISearchBarDelegate, UITableViewDataSource, UISearchDisplayDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSArray *filter;

@end
