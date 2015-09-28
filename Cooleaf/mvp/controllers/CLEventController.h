//
//  CLEventController.h
//  Cooleaf
//
//  Created by Haider Khan on 8/25/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CLClient.h"

@interface CLEventController : NSObject

- (void)getEvents:(NSMutableDictionary *)params success:(void (^)(id JSON))success
           failure:(void (^)(NSError *error))failure;
- (void)getUserEventsWithScope:(NSString *)userId params:(NSDictionary *)params success:(void (^)(id JSON))success
                   failure:(void (^)(NSError *))failure;
- (void)joinEventWithId:(NSInteger)eventId params:(NSDictionary *)params success:(void (^)(id JSON))success
                       failure:(void (^)(NSError *))failure;
- (void)leftEventWithId:(NSInteger)eventId params:(NSDictionary *)params success:(void (^)(id JSON))success
                failure:(void (^)(NSError *))failure;

@end
