//
//  CLLoadQueryEvent.h
//  Cooleaf
//
//  Created by Haider Khan on 9/14/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLLoadQueryEvent : NSObject

@property (nonatomic, assign) NSString *query;
@property (nonatomic, assign) NSString *scope;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger perPage;

- (id)initWithQuery:(NSString *)query scope:(NSString *)scope page:(NSInteger)page perPage:(NSInteger)perPage;

@end
