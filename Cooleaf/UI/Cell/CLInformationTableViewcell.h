//
//  CLInformationTableViewcell.h
//  Cooleaf
//
//  Created by Haider Khan on 9/4/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLUser.h"

@interface CLInformationTableViewcell : UITableViewCell

@property (nonatomic, assign) NSMutableArray *tags;
@property (weak, nonatomic) IBOutlet UILabel *tagLabel;

@end
