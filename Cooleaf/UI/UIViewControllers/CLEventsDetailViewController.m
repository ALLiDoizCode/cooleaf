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

@interface CLEventsDetailViewController ()

@end

@implementation CLEventsDetailViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _scrollView.scrollEnabled = YES;
        
     MKMapView *map = [[MKMapView alloc] initWithFrame:CGRectMake(0, 600, self.view.frame.size.width, 300)];
    
    [_scrollView addSubview:map];
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
    
    //_detailView.detailDescription.text = eventDescription;
    
    [_detailView.detailDescription setText:eventDescription];
    
    
    NSString *eventName = [_currentEvent name];
    
    _detailView.labelName.text = eventName;
    
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
