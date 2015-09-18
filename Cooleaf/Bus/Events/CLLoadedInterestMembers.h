//
//  CLLoadedInterestMembers.h
//  Cooleaf
//
//  Created by Haider Khan on 9/18/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLLoadedInterestMembers : NSObject

@property (nonatomic, assign) NSMutableArray *members;

- (id)initWithMembers:(NSMutableArray *)members;

@end
