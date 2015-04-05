//
//  NPSeriesEvent.m
//  Cooleaf
//
//  Created by Dirk R on 4/5/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import "NPSeriesEvent.h"

@implementation NPSeriesEvent


- (id)initWithDictionary:(NSDictionary *)dictionary
{
	self = [super init];
	
	if (self) {
		_objectId = ((NSNumber *)dictionary[@"id"]).integerValue;
		_name = dictionary[@"name"];
		_startTime = ((NSDate *)dictionary[@"start_time"]);
		_rewardPoints = ((NSNumber *)dictionary[@"reward_points"]).integerValue;
		_participants = ((NSNumber *)dictionary[@"participants_count"]).integerValue;
		_isAttending = dictionary[@"attending"];
		_isJoinable = dictionary[@"joinable"];
	}
	
	return self;
}

- (NSString *)description
{
	return [NSString stringWithFormat:@"%@<%p>::{ id=%d, name=%@, start_time=%@, reward_points=%d, participants_count=%d, joinable=%@, attending=%@ }",
			NSStringFromClass(self.class), self,
			(int)_objectId, _name, _startTime, (int)_rewardPoints, (int)_participants, NSStringFromBool(_isJoinable), NSStringFromBool(_isAttending) ];
}

@end
