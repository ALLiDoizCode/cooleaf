//
//  IInterestDetailInteractor.h
//  Cooleaf
//
//  Created by Haider Khan on 9/29/15.
//  Copyright © 2015 Nova Project. All rights reserved.
//

@protocol IInterestDetailInteractor <NSObject>

- (void)joinedInterest;
- (void)leaveInterest;
- (void)initMembers:(NSMutableArray *)members;

@end
