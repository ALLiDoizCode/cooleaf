//
//  IInterestDetailInteractor.h
//  Cooleaf
//
//  Created by Haider Khan on 9/18/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

@protocol IInterestDetailInteractor <NSObject>

- (void)joinedInterest;
- (void)leaveInterest;
- (void)initMembers:(NSMutableArray *)members;

@end
