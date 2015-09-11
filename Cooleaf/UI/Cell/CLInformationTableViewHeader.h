//
//  CLInformationTableViewHeader.h
//  Cooleaf
//
//  Created by Haider Khan on 9/8/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CLInformationTableViewHeader;
@protocol CLInformationHeaderDelegate <NSObject>

- (void)didPressExpandCollapseButton:(CLInformationTableViewHeader *)header;

@end

@interface CLInformationTableViewHeader : UITableViewHeaderFooterView

@property (nonatomic, assign) id<CLInformationHeaderDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIImageView *infoImage;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;

- (IBAction)expandCollapse:(UIButton *)sender;

@end
