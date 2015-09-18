//
//  CLLoadedInterestFeeds.h
//  Cooleaf
//
//  Created by Haider Khan on 9/18/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLLoadedInterestFeeds : NSObject

@property (nonatomic, assign) NSMutableArray *feeds;

- (id)initWithFeeds:(NSMutableArray *)feeds;

@end
