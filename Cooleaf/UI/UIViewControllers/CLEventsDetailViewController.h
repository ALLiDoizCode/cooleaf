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
#import "BFPaperCheckbox.h"
#import <CoreLocation/CoreLocation.h>

@interface CLEventsDetailViewController : UIViewController <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UIScrollViewDelegate,CLLocationManagerDelegate, BFPaperCheckboxDelegate>

@property (strong, nonatomic) IBOutlet CLEventDetail *detailView;

@property (nonatomic) CLEvent *currentEvent;
@property (nonatomic) UIButton *joinEvents;
@property (nonatomic) UIView *selectionView;
@property (nonatomic) UIView *bgBlur;
@property (nonatomic) UIButton *cancle;
@property (nonatomic) UILabel *date1;
@property (nonatomic) UILabel *date2;
@property (nonatomic) UILabel *date3;
@property (nonatomic) UILabel *date4;
@property (weak, nonatomic) IBOutlet UICollectionView *eventCollectionView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end
