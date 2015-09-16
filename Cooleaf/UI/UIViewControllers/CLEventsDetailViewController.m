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
    
    [_detailView.joinBtn addTarget:self action:@selector(joinSelection) forControlEvents:UIControlEventTouchUpInside];
    
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

-(void)joinSelection {
    
    //Blur
    UIView *bgBlur = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, _detailView.frame.size.height)];
    bgBlur.backgroundColor = [UIColor offBlack];
    bgBlur.alpha = 0.8;
    
    //Background View
    UIView *selectionView = [[UIView alloc] initWithFrame:CGRectMake(65, 100, 200, 200)];
    selectionView.backgroundColor = [UIColor offWhite];
    
    selectionView.layer.cornerRadius = 3;
    selectionView.layer.masksToBounds = YES;
    
    BFPaperCheckbox *paperCheckbox = [[BFPaperCheckbox alloc] initWithFrame:CGRectMake(10, 10, bfPaperCheckboxDefaultRadius * 2, bfPaperCheckboxDefaultRadius * 2)];
    paperCheckbox.tag = 1001;
    paperCheckbox.rippleFromTapLocation = NO;
    paperCheckbox.tapCirclePositiveColor = [UIColor paperColorAmber]; // We could use [UIColor colorWithAlphaComponent] here to make a better tap-circle.
    paperCheckbox.tapCircleNegativeColor = [UIColor paperColorRed];   // We could use [UIColor colorWithAlphaComponent] here to make a better tap-circle.
    paperCheckbox.checkmarkColor = [UIColor UIColorFromRGB:0x00BCD5];
    
    BFPaperCheckbox *paperCheckbox2 = [[BFPaperCheckbox alloc] initWithFrame:CGRectMake(10, 30, bfPaperCheckboxDefaultRadius * 2, bfPaperCheckboxDefaultRadius * 2)];
    paperCheckbox2.center = CGPointMake(paperCheckbox.center.x, paperCheckbox2.frame.origin.y);
    paperCheckbox2.tag = 1002;
    paperCheckbox2.rippleFromTapLocation = NO;
    paperCheckbox2.tapCirclePositiveColor = [UIColor paperColorAmber]; // We could use [UIColor colorWithAlphaComponent] here to make a better tap-circle.
    paperCheckbox2.tapCircleNegativeColor = [UIColor paperColorRed];   // We could use [UIColor colorWithAlphaComponent] here to make a better tap-circle.
    paperCheckbox2.checkmarkColor = [UIColor UIColorFromRGB:0x00BCD5];
    
    BFPaperCheckbox *paperCheckbox3 = [[BFPaperCheckbox alloc] initWithFrame:CGRectMake(10, 50, bfPaperCheckboxDefaultRadius * 2, bfPaperCheckboxDefaultRadius * 2)];
      paperCheckbox3.center = CGPointMake(paperCheckbox.center.x, paperCheckbox3.frame.origin.y);
    paperCheckbox3.tag = 1003;
    paperCheckbox3.rippleFromTapLocation = NO;
    paperCheckbox3.tapCirclePositiveColor = [UIColor paperColorAmber]; // We could use [UIColor colorWithAlphaComponent] here to make a better tap-circle.
    paperCheckbox3.tapCircleNegativeColor = [UIColor paperColorRed];   // We could use [UIColor colorWithAlphaComponent] here to make a better tap-circle.
    paperCheckbox3.checkmarkColor = [UIColor UIColorFromRGB:0x00BCD5];
    
    BFPaperCheckbox *paperCheckbox4 = [[BFPaperCheckbox alloc] initWithFrame:CGRectMake(10, 70, bfPaperCheckboxDefaultRadius * 2, bfPaperCheckboxDefaultRadius * 2)];
    paperCheckbox4.center = CGPointMake(paperCheckbox.center.x, paperCheckbox4.frame.origin.y);
    paperCheckbox4.tag = 1004;
    paperCheckbox4.rippleFromTapLocation = NO;
    paperCheckbox4.tapCirclePositiveColor = [UIColor paperColorAmber]; // We could use [UIColor colorWithAlphaComponent] here to make a better tap-circle.
    paperCheckbox4.tapCircleNegativeColor = [UIColor paperColorRed];   // We could use [UIColor colorWithAlphaComponent] here to make a better tap-circle.
    paperCheckbox4.checkmarkColor = [UIColor redColor];
    
    [_scrollView addSubview:bgBlur];
    [self.view addSubview:selectionView];
    [selectionView addSubview:paperCheckbox];
    [selectionView addSubview:paperCheckbox2];
    [selectionView addSubview:paperCheckbox3];
    [selectionView addSubview:paperCheckbox4];


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
