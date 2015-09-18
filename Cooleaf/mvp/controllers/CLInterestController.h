//
//  CLInterestController.h
//  Cooleaf
//
//  Created by Haider Khan on 8/25/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLInterestController : NSObject

- (void)getInterests:(NSMutableDictionary *)params success:(void (^)(id JSON))success
          failure:(void (^)(NSError *error))failure;
- (void)getInterestMembers:(NSInteger)interestId params:(NSDictionary *)params success:(void (^)(id JSON))success
             failure:(void (^)(NSError *error))failure;
- (void)joinInterest:(NSInteger)interestId params:(NSDictionary *)params success:(void (^)(id JSON))success
                   failure:(void (^)(NSError *error))failure;
- (void)leaveInterest:(NSInteger)interestId params:(NSDictionary *)params success:(void (^)(id JSON))success
             failure:(void (^)(NSError *error))failure;

@end
