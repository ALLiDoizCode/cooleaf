//
//  CLLoadEventParticipants.h
//  Cooleaf
//
//  Created by Haider Khan on 9/22/15.
//  Copyright © 2015 Nova Project. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLLoadEventParticipants : NSObject

@property (nonatomic, assign) NSInteger eventId;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger perPage;

- (id)initWithEventId:(NSInteger)eventId page:(NSInteger)page perPage:(NSInteger)perPage;

@end
