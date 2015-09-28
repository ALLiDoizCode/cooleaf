//
//  CLEventsDetailViewController.h
//  Cooleaf
//
//  Created by Jonathan Green on 9/11/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "CLEvent.h"
#import "CLEventDetail.h"
#import "BFPaperCheckbox.h"
#import "IEventDetailInteractor.h"
#import "IParticipantInteractor.h"

@interface CLEventDetailViewController : UIViewController <IEventDetailInteractor, IParticipantInteractor, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate, CLLocationManagerDelegate, MKMapViewDelegate, BFPaperCheckboxDelegate>

@property (strong, nonatomic) IBOutlet CLEventDetail *detailView;
@property (nonatomic, assign) CLEvent *event;
@property (nonatomic, assign) UIImageView *eventImageView;
@property (nonatomic) UIButton *joinEvents;
@property (nonatomic) UIView *selectionView;
@property (nonatomic) UIView *bgBlur;
@property (nonatomic) UIButton *cancel;
@property (nonatomic) UILabel *date1;
@property (nonatomic) UILabel *date2;
@property (nonatomic) UILabel *date3;
@property (nonatomic) UILabel *date4;
@property (weak, nonatomic) IBOutlet UICollectionView *eventCollectionView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end
