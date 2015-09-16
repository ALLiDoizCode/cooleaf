//
//  CLEventsDetailViewController.h
//  Cooleaf
//
//  Created by Jonathan Green on 9/11/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLEvent.h"
#import "CLEventDetail.h"

@interface CLEventsDetailViewController : UIViewController <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate>

@property (strong, nonatomic) IBOutlet CLEventDetail *detailView;

@property (nonatomic) CLEvent *currentEvent;
@property (weak, nonatomic) IBOutlet UICollectionView *eventCollectionView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end
