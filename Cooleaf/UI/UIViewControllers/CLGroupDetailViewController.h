//
//  CLGroupDetailViewController.h
//  Cooleaf
//
//  Created by Jonathan Green on 9/4/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLDetailView.h"
#import "CLGroupPostViewcontroller.h"

@interface CLGroupDetailViewController : UIViewController

@property (nonatomic) NSString *currentImage;
@property (nonatomic) NSString *currentName;
@property (strong, nonatomic) IBOutlet CLDetailView *detailView;

@end
