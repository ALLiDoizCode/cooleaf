//
//  NPLocationCell.m
//  Cooleaf
//
//  Created by Bazyli Zygan on 06.01.2014.
//  Copyright (c) 2014 Nova Project. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "NPLocationCell.h"

@interface NPLocationPin : NSObject <MKAnnotation>

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;

@end

@implementation NPLocationPin


@end

@interface NPLocationCell ()
{
    CLLocation *_location;
    NPLocationPin *_pin;
}
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet MKMapView *locationMap;
@property (weak, nonatomic) IBOutlet UIView *bottomSeparator;

@end

@implementation NPLocationCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    self.separatorInset = UIEdgeInsetsZero;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setAddress:(NSDictionary *)address
{
    _address = address;
    _locationLabel.text = [NSString stringWithFormat:@"%@\n%@", address[@"address1"], address[@"address2"]];
    if (_address[@"lat"])
    {
        _location = [[CLLocation alloc] initWithLatitude:[_address[@"lat"] doubleValue] longitude:[_address[@"lng"] doubleValue]];
        _locationMap.centerCoordinate = _location.coordinate;
        if (_pin)
            [_locationMap removeAnnotation:_pin];
        
        _pin = [NPLocationPin new];
        _pin.title = _address[@"name"];
        _pin.coordinate = _location.coordinate;
        MKCoordinateRegion region;
        
        region.span.latitudeDelta = 0.01;
        region.span.longitudeDelta = 0.01;
        region.center.latitude = _location.coordinate.latitude + 0.003;
        region.center.longitude = _location.coordinate.longitude;
        [_locationMap setRegion:region animated:NO];
        [_locationMap addAnnotation:_pin];
    }
}

- (IBAction)openMapsTapped:(id)sender
{
    Class mapItemClass = [MKMapItem class];
    if (mapItemClass && [mapItemClass respondsToSelector:@selector(openMapsWithItems:launchOptions:)])
    {
        // Create an MKMapItem to pass to the Maps app
        MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:_location.coordinate
                                                       addressDictionary:nil];
        MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
        [mapItem setName:_address[@"name"]];
        // Pass the map item to the Maps app
        [mapItem openInMapsWithLaunchOptions:nil];
    }
}

@end
