//
//  CLParticipantSubscriber.m
//  Cooleaf
//
//  Created by Haider Khan on 9/22/15.
//  Copyright © 2015 Nova Project. All rights reserved.
//

#import "CLParticipantSubscriber.h"
#import "CLParticipantController.h"
#import "CLLoadEventParticipants.h"
#import "CLLoadedEventParticipants.h"

@interface CLParticipantSubscriber() {
    @private
    CLParticipantController *_participantController;
}

@end

@implementation CLParticipantSubscriber

# pragma mark - init

- (id)init {
    _participantController = [[CLParticipantController alloc] init];
    return self;
}

# pragma mark - subscription events

SUBSCRIBE(CLLoadEventParticipants) {
    // Initialize parameters
    NSInteger eventId = event.eventId;
    NSDictionary *params = @{
                             @"page": [NSString stringWithFormat:@"%lu", (long) event.page],
                             @"per_page": [NSString stringWithFormat:@"%lu", (long) event.perPage]
                             };
    
    [_participantController getEventParticipants:eventId params:params success:^(id JSON) {
        NSMutableArray *participants = [JSON result];
        CLLoadedEventParticipants *loadedEventParticipants = [[CLLoadedEventParticipants alloc] initWithParticipants:participants];
        PUBLISH(loadedEventParticipants);
    } failure:^(NSError *error) {
        NSLog(@"%@", error);
    }];
}

@end
