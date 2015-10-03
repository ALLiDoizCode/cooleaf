//
//  NPInterestsHeaderViewCell.h
//  Cooleaf
//
//  Created by Curtis Jones on 2015.03.17.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NPInterestsHeaderViewCell : UICollectionViewCell

@property (readwrite, strong, nonatomic) void (^backHandler)();
@property (readwrite, strong, nonatomic) void (^nextHandler)();

@end
