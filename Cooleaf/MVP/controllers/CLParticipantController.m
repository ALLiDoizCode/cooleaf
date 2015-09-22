//
//  CLParticipantController.m
//  Cooleaf
//
//  Created by Haider Khan on 9/22/15.
//  Copyright © 2015 Nova Project. All rights reserved.
//

#import "CLParticipantController.h"
#import "CLClient.h"

static NSString *const kParticipantsPath = @"v2/participants/";

@implementation CLParticipantController

- (void)getEventParticipants:(NSInteger)eventId params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure {
    NSString *path = [NSString stringWithFormat:@"%@%d%@", kParticipantsPath, (int) eventId, @".json"];
    [[CLClient getInstance] GET:path parameters:params completion:^(id response, NSError *error) {
       if (!error)
           success(response);
       else
           failure(error);
    }];
}

@end
