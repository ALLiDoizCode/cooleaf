//
//  CLLoadEventsScope.h
//  Cooleaf
//
//  Created by Haider Khan on 9/5/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLLoadUserEvents : NSObject

@property (nonatomic, assign) NSString *userIdString;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger perPage;
@property (nonatomic, assign) NSString *scope;

- (id)initWithUserId:(NSString *)userIdString page:(NSInteger)page perPage:(NSInteger)perPage scope:(NSString *)scope;

@end
