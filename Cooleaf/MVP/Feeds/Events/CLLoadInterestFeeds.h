//
//  CLLoadInterestFeeds.h
//  Cooleaf
//
//  Created by Haider Khan on 9/18/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLLoadInterestFeeds : NSObject

@property (nonatomic, assign) NSInteger interestId;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger perPage;

- (id)initWithId:(NSInteger)interestId page:(NSInteger)page perPage:(NSInteger)perPage;

@end
