//
//  CLPeopleViewController.h
//  Cooleaf
//
//  Created by Jonathan Green on 9/10/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IUserInteractor.h"
#import "IParticipantInteractor.h"
#import "IInterestDetailInteractor.h"
#import "CLEvent.h"
#import "CLInterest.h"

@interface CLPeopleViewController : UIViewController <IUserInteractor, IParticipantInteractor, IInterestDetailInteractor, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, assign) NSString *currentView;
@property (nonatomic, assign) CLEvent *event;
@property (nonatomic, assign) CLInterest *interest;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
