//
//  CLEventsDetailViewController.m
//  Cooleaf
//
//  Created by Jonathan Green on 9/11/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "CLEventsDetailViewController.h"
#import "CLImage.h"
#import "CLEventCollectionCell.h"
#import "UIColor+CustomColors.h"
#import <MapKit/MapKit.h>
#import "UIColor+BFPaperColors.h"
#import <FXBlurView.h>

@interface CLEventsDetailViewController ()

@end

@implementation CLEventsDetailViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor offWhite];
    
    [_detailView.joinBtn addTarget:self action:@selector(joinSelection) forControlEvents:UIControlEventTouchUpInside];
    
    _scrollView.scrollEnabled = YES;
    
    _scrollView.contentSize = _detailView.frame.size;
    
     self.navigationController.navigationBar.tintColor = [UIColor offWhite];
    
    UICollectionViewFlowLayout *layout;
    
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    
    [_eventCollectionView setShowsHorizontalScrollIndicator:NO];
    [_eventCollectionView setShowsVerticalScrollIndicator:NO];
    _detailView.backgroundColor = [UIColor offWhite];
    
    // Get the image url
    CLImage *eventImage = [_currentEvent eventImage];
    NSString *imageUrl = eventImage.url;
    NSString *fullPath = [NSString stringWithFormat:@"%@%@", @"http:", imageUrl];
    fullPath = [fullPath stringByReplacingOccurrencesOfString:@"{{SIZE}}" withString:@"1600x400"];
    
    _detailView.mainImageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:fullPath]]];
    
  
    // Get the event description
    NSString *eventDescription = [_currentEvent eventDescription];
    
    _detailView.detailDescription.text = eventDescription;
    
    NSString *eventName = [_currentEvent name];
    
    _detailView.labelName.text = eventName;
    
    // Get the locaiton and setup the map
    
    ///replace with location/////////////////////////////
    NSString *eventlocation = @"3423 Piedmont Rd NE, Atlanta, GA 30305";
    ////////////////////////////////////////////////////
    
    [self setupMap:eventlocation];
    
}

-(void)layoutSubviews {
    
    _scrollView.scrollEnabled = YES;
    [_scrollView setContentSize: CGSizeMake(2400,8000)];
    
}

-(void)viewWillAppear:(BOOL)animated {
    
    self.navigationController.navigationBar.alpha = 0.7;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 4;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CLEventCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectioCell" forIndexPath:indexPath];
    
    cell.memberImage.image = [UIImage imageNamed:@"TestImage"];
    
    return cell;
}

-(void)joinSelection {
    
    //Blur
    _bgBlur = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, _detailView.frame.size.height)];
    _bgBlur.backgroundColor = [UIColor offBlack];
    _bgBlur.alpha = 0.8;
    
    //Background View
    _selectionView = [[UIView alloc] initWithFrame:CGRectMake(65, 100, 200, 250)];
    _selectionView.backgroundColor = [UIColor offWhite];
    _selectionView.layer.cornerRadius = 3;
    _selectionView.layer.masksToBounds = YES;
    
    BFPaperCheckbox *paperCheckbox = [[BFPaperCheckbox alloc] initWithFrame:CGRectMake(0, 10, bfPaperCheckboxDefaultRadius * 2, bfPaperCheckboxDefaultRadius * 2)];
    paperCheckbox.tag = 1001;
    paperCheckbox.checkmarkColor = [UIColor UIColorFromRGB:0x00BCD5];
   
    BFPaperCheckbox *paperCheckbox2 = [[BFPaperCheckbox alloc] initWithFrame:CGRectMake(0, 60, bfPaperCheckboxDefaultRadius * 2, bfPaperCheckboxDefaultRadius * 2)];
    paperCheckbox2.tag = 1002;
    paperCheckbox2.checkmarkColor = [UIColor UIColorFromRGB:0x00BCD5];
    
    BFPaperCheckbox *paperCheckbox3 = [[BFPaperCheckbox alloc] initWithFrame:CGRectMake(0, 110, bfPaperCheckboxDefaultRadius * 2, bfPaperCheckboxDefaultRadius * 2)];
    paperCheckbox3.tag = 1003;
    paperCheckbox3.checkmarkColor = [UIColor UIColorFromRGB:0x00BCD5];
    
    BFPaperCheckbox *paperCheckbox4 = [[BFPaperCheckbox alloc] initWithFrame:CGRectMake(0, 160, bfPaperCheckboxDefaultRadius * 2, bfPaperCheckboxDefaultRadius * 2)];
    paperCheckbox4.tag = 1004;
    paperCheckbox4.checkmarkColor = [UIColor UIColorFromRGB:0x00BCD5];
    
    UILabel *selectTitle = [[UILabel alloc] initWithFrame:CGRectMake(15, -10, 200, 50)];
    selectTitle.text = @"Select Events";
    selectTitle.textColor = [UIColor offBlack];
    selectTitle.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:14];
    
    //dates
    _date1 = [[UILabel alloc] initWithFrame:CGRectMake(60, 22, 200, 50)];
    _date1.text = @"sep 17, 9:00 PM";
    _date1.textColor = [UIColor offBlack];
    _date1.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:13];
    
    _date2 = [[UILabel alloc] initWithFrame:CGRectMake(60, 72, 200, 50)];
    _date2.text = @"sep 18, 10:00 PM";
    _date2.textColor = [UIColor offBlack];
    _date2.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:13];

    _date3 = [[UILabel alloc] initWithFrame:CGRectMake(60, 122, 200, 50)];
    _date3.text = @"sep 19, 9:00 PM";
    _date3.textColor = [UIColor offBlack];
    _date3.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:13];

    
    _date4 = [[UILabel alloc] initWithFrame:CGRectMake(60, 172, 200, 50)];
    _date4.text = @"sep 20, 10:00 PM";
    _date4.textColor = [UIColor offBlack];
    _date4.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:13];

    
    //Cancle
    _cancle = [UIButton buttonWithType: UIButtonTypeRoundedRect];
    _cancle.frame = CGRectMake(50, 220, 75, 30);
    [_cancle setTitle:@"CANCLE" forState:UIControlStateNormal];
    _cancle.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:11];
    _cancle.backgroundColor = [UIColor clearColor];
    _cancle.tintColor = [UIColor UIColorFromRGB:0x00BCD5];
    _cancle.layer.cornerRadius = 2;
    _cancle.layer.masksToBounds = YES;
    [_cancle addTarget:self action:@selector(cancleJoin) forControlEvents:UIControlEventTouchUpInside];
    
    //Join
    _joinEvents = [UIButton buttonWithType: UIButtonTypeRoundedRect];
    _joinEvents.frame = CGRectMake(120, 220, 75, 30);
    [_joinEvents setTitle:@"JOIN EVENTS" forState:UIControlStateNormal];
    _joinEvents.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:11];
    _joinEvents.backgroundColor = [UIColor clearColor];
    _joinEvents.tintColor = [UIColor UIColorFromRGB:0x00BCD5];
    _joinEvents.layer.cornerRadius = 2;
    _joinEvents.layer.masksToBounds = YES;
    //[_joinEvents addTarget:self action:@selector(somefunc:) forControlEvents:UIControlEventTouchUpInside];
    
    [_scrollView addSubview:_bgBlur];
    [self.view addSubview:_selectionView];
    [_selectionView addSubview:selectTitle];
    [_selectionView addSubview:_joinEvents];
    [_selectionView addSubview:_cancle];
    [_selectionView addSubview:_date1];
    [_selectionView addSubview:_date2];
    [_selectionView addSubview:_date3];
    [_selectionView addSubview:_date4];
    [_selectionView addSubview:paperCheckbox];
    [_selectionView addSubview:paperCheckbox2];
    [_selectionView addSubview:paperCheckbox3];
    [_selectionView addSubview:paperCheckbox4];


}

-(void)cancleJoin{
    
    _selectionView.hidden = YES;
    _bgBlur.hidden =YES;
}


- (CGFloat)getLabelHeight:(UILabel*)label {
    
    CGSize constraint = CGSizeMake(label.frame.size.width, 260.0f);
    CGSize size;
    
    NSStringDrawingContext *context = [[NSStringDrawingContext alloc] init];
    CGSize boundingBox = [label.text boundingRectWithSize:constraint
                                                  options:NSStringDrawingUsesLineFragmentOrigin
                                               attributes:@{NSFontAttributeName:label.font}
                                                  context:context].size;
    
    size = CGSizeMake(ceil(boundingBox.width), ceil(boundingBox.height));
    
    return size.height;
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay
{
    if ([overlay isKindOfClass:[MKPolyline class]]) {
        MKPolylineRenderer *renderer = [[MKPolylineRenderer alloc] initWithOverlay:overlay];
        [renderer setStrokeColor:[UIColor blueColor]];
        [renderer setLineWidth:5.0];
        return renderer;
    }
    return nil;
}

-(void)setupMap:(NSString *)location{
    
    MKMapView *map;
    
    if (location != nil) {
        
        map = [[MKMapView alloc] initWithFrame:CGRectMake(15, 590, self.view.frame.size.width- 28, 255)];
        map.layer.cornerRadius = 2;
        map.layer.masksToBounds = YES;
        
        CLGeocoder *geocoder = [[CLGeocoder alloc] init];
        [geocoder geocodeAddressString:location
                     completionHandler:^(NSArray* placemarks, NSError* error){
                         if (placemarks && placemarks.count > 0) {
                             CLPlacemark *topResult = [placemarks objectAtIndex:0];
                             MKPlacemark *placemark = [[MKPlacemark alloc] initWithPlacemark:topResult];
                             
                             MKCoordinateRegion region = map.region;
                             region.center = placemark.region.center;
                             region.span.longitudeDelta /= 2000.0;
                             region.span.latitudeDelta /= 2000.0;
                             
                             [map setRegion:region animated:YES];
                             [map addAnnotation:placemark];
                         }
                     }
         ];
        
        [_scrollView addSubview:map];
        
    }else {
        
        _scrollView.contentSize = CGSizeMake(_detailView.frame.size.width, _detailView.frame.size.height - 255);
    }
    
   
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
