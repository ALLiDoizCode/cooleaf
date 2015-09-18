//
//  CLGroupDetailViewController.h
//  Cooleaf
//
//  Created by Jonathan Green on 9/4/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLDetailView.h"
#import "CLInterest.h"
#import "IInterestDetailInteractor.h"

@interface CLGroupDetailViewController : UIViewController <IInterestDetailInteractor, CLDetailViewDelegate, UITableViewDelegate, UITableViewDataSource, UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic) NSString *currentImagePath;
@property (nonatomic) NSString *currentName;
@property (nonatomic, assign) CLInterest *interest;
@property (strong, nonatomic) IBOutlet CLDetailView *detailView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIScrollView *detailScroll;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end
