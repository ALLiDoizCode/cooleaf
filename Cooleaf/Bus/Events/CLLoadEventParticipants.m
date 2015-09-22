//
//  CLLoadEventParticipants.m
//  Cooleaf
//
//  Created by Haider Khan on 9/22/15.
//  Copyright © 2015 Nova Project. All rights reserved.
//

#import "CLLoadEventParticipants.h"

@implementation CLLoadEventParticipants

- (id)initWithEventId:(NSInteger)eventId page:(NSInteger)page perPage:(NSInteger)perPage {
    _eventId = eventId;
    _page = page;
    _perPage = perPage;
    return self;
}

@end
