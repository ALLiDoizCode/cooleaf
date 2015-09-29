//
//  CLParticipantController.h
//  Cooleaf
//
//  Created by Haider Khan on 9/22/15.
//  Copyright © 2015 Nova Project. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CLParticipantController : NSObject

- (void)getEventParticipants:(NSInteger)eventId params:(NSDictionary *)params success:(void (^)(id JSON))success
                 failure:(void (^)(NSError *error))failure;

@end
