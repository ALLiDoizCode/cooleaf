//
//  CLEventsDetailViewController.m
//  Cooleaf
//
//  Created by Jonathan Green on 9/11/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import <SDWebImage/UIImageView+WebCache.h>
#import <FXBlurView.h>
#import <MapKit/MapKit.h>
#import "CLEventDetailViewController.h"
#import "CLImage.h"
#import "CLEventCollectionCell.h"
#import "UIColor+CustomColors.h"
#import "UIColor+BFPaperColors.h"
#import "CLEventPresenter.h"
#import "UIColor+CustomColors.h"
#import "CLParticipantPresenter.h"
#import "CLClient.h"
#import "CLDateUtil.h"
#import "CLNavigation.h"

@interface CLEventDetailViewController()

@property (nonatomic, strong) CLEventPresenter *eventPresenter;
@property (nonatomic, strong) CLParticipantPresenter *participantPresenter;
@property (nonatomic, strong) NSMutableArray *participants;

@end

@implementation CLEventDetailViewController

# pragma mark - LifeCycle Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Add join API call to join button
    [_detailView.joinBtn addTarget:self action:@selector(joinEvent) forControlEvents:UIControlEventTouchUpInside];
    
    // Add selector for participants button to go to people view controller
    [_detailView.participantsButton addTarget:self action:@selector(goToPeopleController) forControlEvents:UIControlEventTouchUpInside];
    
    [self setupMainView];
    [self setupScrollView];
    [self setupEventCollectionView];
    [self setupFlowLayout];
    [self setupEventImage];
    [self setupEventLabels];
    [self setupEventMap];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // Adjust navigation drawer
    self.navigationController.navigationBar.alpha = 1.0;
    self.navigationController.navigationBar.barTintColor = [UIColor eventColor];
    
    [self initEventPresenter];
    [self initParticipantPresenter];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    // Remove title when coming back from participants
    self.navigationController.navigationBar.topItem.title = @"";
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    if (_eventPresenter)
        [_eventPresenter unregisterOnBus];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma mark - initEventPresenter

- (void)initEventPresenter {
    _eventPresenter = [[CLEventPresenter alloc] initWithDetailInteractor:self];
    [_eventPresenter registerOnBus];
}

# pragma mark - initParticipantPresenter 

- (void)initParticipantPresenter {
    _participantPresenter = [[CLParticipantPresenter alloc] initWithInteractor:self];
    [_participantPresenter registerOnBus];
    [_participantPresenter loadEventParticipants:[[_event eventId] integerValue]];
}

# pragma mark - IEventDetailInteractor Methods

- (void)joinedEvent {
    // Joined event, change button to leave and reload participants
    [_participantPresenter loadEventParticipants:[[_event eventId] integerValue]];
    [_detailView.joinBtn setTitle:@"Leave" forState:UIControlStateNormal];
}

- (void)leftEvent {
    // Joined event, change button to leave and reload participants
    [_participantPresenter loadEventParticipants:[[_event eventId] integerValue]];
    [_detailView.joinBtn setTitle:@"Join" forState:UIControlStateNormal];
}

# pragma mark - IParticipantInteractor Methods

- (void)initParticipants:(NSMutableArray *)participants {
    // Create an NSMutableArray with only 4 participants
    _participants = [NSMutableArray new];
    
    // Get count
    int count = (int) [participants count];
    
    // Initialize a participants mutable array with 4 or less participants
    // If count is less than 4 then use count
    if (count >= 4) {
        for (int i = 0; i < 4; i++) {
            CLParticipant *participant = [participants objectAtIndex:i];
            [_participants addObject:participant];
        }
    } else {
        for (int i = 0; i < count; i++) {
            CLParticipant *participant = [participants objectAtIndex:i];
            [_participants addObject:participant];
        }
    }
    
    // Reload collectionview to show after initialization
    [self.eventCollectionView reloadData];
}

# pragma mark - layoutSubviews

- (void)layoutSubviews {
    _scrollView.scrollEnabled = YES;
    [_scrollView setContentSize: CGSizeMake(2400, 8000)];
}

# pragma mark - setupMainView

- (void)setupMainView {
    self.view.backgroundColor = [UIColor offWhite];
    self.navigationController.navigationBar.tintColor = [UIColor offWhite];
    _detailView.backgroundColor = [UIColor offWhite];
}

# pragma mark - setupScrollView

- (void)setupScrollView {
    _scrollView.scrollEnabled = YES;
    _scrollView.contentSize = _detailView.frame.size;
}

# pragma mark - setupEventCollectionView 

- (void)setupEventCollectionView {
    [_eventCollectionView setShowsHorizontalScrollIndicator:NO];
    [_eventCollectionView setShowsVerticalScrollIndicator:NO];
}

# pragma mark - setupFlowLayout

- (void)setupFlowLayout {
    UICollectionViewFlowLayout *layout;
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
}

# pragma mark - setupEventImage

- (void)setupEventImage {
    // Get the image url
    CLImage *eventImage = [_event eventImage];
    NSString *imageUrl = eventImage.url;
    NSString *fullPath = [NSString stringWithFormat:@"%@%@", @"http:", imageUrl];
    fullPath = [fullPath stringByReplacingOccurrencesOfString:@"{{SIZE}}" withString:@"1600x400"];
    
    // Set the image
    _detailView.mainImageView.image = _eventImageView.image;
}

# pragma mark - setupEventLabels

- (void)setupEventLabels {
    // Set the event description
    NSString *eventDescription = [_event eventDescription];
    _detailView.detailDescription.text = eventDescription;
    
    // Set the event name
    NSString *eventName = [_event name];
    _detailView.labelName.text = eventName;
    
    // Rewards label
    _detailView.labelRewards.text = [NSString stringWithFormat:@"%d %@", [[_event rewardPoints] intValue], @"Rewards"];
    
    // Set coordinator name
    NSDictionary *eventDict = [_event dictionaryValue];
    _detailView.labelSub.text = eventDict[@"coordinator"][@"name"];
    
    // Set participants count, check if less than or equal to 1 then adjust text
    int participantsCount = [[_event participantsCount] intValue];
    if (participantsCount <= 1) {
        [_detailView.participantsButton setTitle:[NSString
                                        stringWithFormat:@"%d Participant >", participantsCount]
                                        forState:UIControlStateNormal];
    } else {
        [_detailView.participantsButton setTitle:[NSString
                                        stringWithFormat:@"%d Participants >", participantsCount]
                                        forState:UIControlStateNormal];
    }
    
    // Set the date
    NSString *readableDate = [CLDateUtil getReadableDateFromUnixString:[_event startTime]];
    _detailView.labelDate.text = readableDate;
    
    // Adjust join button
    BOOL attending = [_event isAttending];
    if (attending)
        [_detailView.joinBtn setTitle:@"Leave" forState:UIControlStateNormal];
    else
        [_detailView.joinBtn setTitle:@"Join" forState:UIControlStateNormal];
}

# pragma mark - setupEventMap

- (void)setupEventMap {
    // Get the locaiton
    NSDictionary *addressDict = (NSDictionary *) [_event address];
    
    int addressItemCount = (int) [addressDict count];
    
    if (addressItemCount > 0) {
        // Build address
        NSString *address1 = addressDict[@"address1"];
        NSString *city = addressDict[@"city"];
        NSString *state = addressDict[@"state"];
        NSString *zip = addressDict[@"zip"];
        NSString *fullAddress = [NSString stringWithFormat:@"%@, %@ %@, %@", address1, city, state, zip];
    
        // Set into map
        [self setupMap:fullAddress];
    } else {
        // Hide location
        _detailView.labelLocation.hidden = YES;
    }
}

# pragma mark - goToPeopleController

-(void)goToPeopleController{
    CLNavigation *navigateTo = [[CLNavigation alloc] init];
    [navigateTo eventPeopleController:self.navigationController event:_event];
}

# pragma mark - Participants CollectionView Data Source

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_participants count];
}

# pragma mark - Participants CollectionView Delegate

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CLEventCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionCell" forIndexPath:indexPath];
    
    // Get the participant
    CLParticipant *participant = [_participants objectAtIndex:[indexPath row]];
    
    // Get the participant dictionary
    NSDictionary *participantDict = (NSDictionary *) participant;
    
    // Get path
    NSString *imageUrlPath = participantDict[@"profile"][@"picture"][@"versions"][@"icon"];
    
    // Set the path and load the image
    NSString *fullImagePath = [NSString stringWithFormat:@"%@%@", [CLClient getBaseApiURL], imageUrlPath];
    [cell.memberImage sd_setImageWithURL:[NSURL URLWithString: fullImagePath] placeholderImage:[UIImage imageNamed:@"AvatarPlaceholderMaleMedium"]];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    // Go to people view controller if user touches member icon
    [self goToPeopleController];
}

# pragma mark - joinEvent

- (void)joinEvent {
    BOOL attending = [_event isAttending];
    if (attending)
        [_eventPresenter leaveEvent:[[_event eventId] integerValue]];
    else
        [_eventPresenter joinEvent:[[_event eventId] integerValue]];
}

# pragma mark - getLabelHeight

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

# pragma mark - MapView Renderer

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay {
    if ([overlay isKindOfClass:[MKPolyline class]]) {
        MKPolylineRenderer *renderer = [[MKPolylineRenderer alloc] initWithOverlay:overlay];
        [renderer setStrokeColor:[UIColor blueColor]];
        [renderer setLineWidth:5.0];
        return renderer;
    }
    return nil;
}

# pragma mark - setupMap

-(void)setupMap:(NSString *)location{
    
    MKMapView *map;
    
    if (location != nil || [location isEqualToString:@""]) {
        
        map = [[MKMapView alloc] initWithFrame:CGRectMake(15, 640, self.view.frame.size.width - 28, 200)];
        map.layer.borderWidth = 2;
        map.layer.borderColor = [UIColor offBlack].CGColor;
        map.layer.cornerRadius = 1.5;
        map.layer.masksToBounds = YES;
        map.delegate = self;
        
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
    } else {
        
        if ([[UIScreen mainScreen] bounds].size.height >= 568 || [[UIScreen mainScreen] bounds].size.width >= 568 ) {
            //device = DEVICE_TYPE_IPHONE5 ;
            _scrollView.contentSize = CGSizeMake(_detailView.frame.size.width, _detailView.frame.size.height - 255);
        } else {
            //device = DEVICE_TYPE_IPHONE4 ;
            _scrollView.contentSize = CGSizeMake(_detailView.frame.size.width, _detailView.frame.size.height - 195);
        }
        
    }
}

# pragma mark - MapView Delegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    
    MKPinAnnotationView *pinView = nil;
    
    static NSString *defaultPinID = @"EventDetailAnnotation";
    pinView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:defaultPinID];
    if ( pinView == nil ) {
        pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:defaultPinID];
        
        pinView.pinColor = MKPinAnnotationColorGreen;
        
        pinView.enabled = YES;
        pinView.canShowCallout = YES;
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        
        //Accessoryview for the annotation view in ios.
        pinView.rightCalloutAccessoryView = btn;
    } else {
        pinView.annotation = annotation;
    }
    
    return pinView;
}

- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
    id<MKAnnotation> annotation = view.annotation;
    CLLocationCoordinate2D coordinate = [annotation coordinate];
    MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:coordinate addressDictionary:nil];
    MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
    mapItem.name = annotation.title;
    [mapItem openInMapsWithLaunchOptions:nil];
}

- (void)mapView:(MKMapView *)mapView didAddAnnotationViews:(NSArray<MKAnnotationView *> *)views {
    // Use this to show pop up over map annotation when user enters event detail
    [mapView selectAnnotation:[[mapView annotations] lastObject] animated:YES];
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
