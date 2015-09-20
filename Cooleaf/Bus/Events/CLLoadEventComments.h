//
//  CLLoadEventComments.h
//  Cooleaf
//
//  Created by Haider Khan on 9/20/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLLoadEventComments : NSObject

@property (nonatomic, assign) NSInteger eventId;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger perPage;

- (id)initWithId:(NSInteger)eventId page:(NSInteger)page perPage:(NSInteger)perPage;

@end
