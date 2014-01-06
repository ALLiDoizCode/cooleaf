//
//  NPLocationCell.m
//  Cooleaf
//
//  Created by Bazyli Zygan on 06.01.2014.
//  Copyright (c) 2014 Nova Project. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "NPLocationCell.h"

@interface NPLocationCell ()
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet MKMapView *locationMap;

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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setAddress:(NSDictionary *)address
{
    _address = address;
}

- (IBAction)openMapsTapped:(id)sender {
}

@end
