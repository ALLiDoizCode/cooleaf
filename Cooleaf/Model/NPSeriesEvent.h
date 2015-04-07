//
//  NPSeriesEvent.h
//  Cooleaf
//
//  Created by Dirk R on 4/5/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NPSeriesEvent : NSObject

@property (readwrite, assign, nonatomic) NSUInteger objectId;
@property (readwrite, retain, nonatomic) NSString *name;
@property (readwrite, assign, nonatomic) NSString *startTime;
@property (readwrite, assign, nonatomic) NSUInteger rewardPoints;
@property (readwrite, assign, nonatomic) NSUInteger participants;
@property (readwrite, assign, nonatomic) BOOL isAttending;
@property (readwrite, assign, nonatomic) BOOL isJoinable;


/******
{
	"id": 975,
	"slug": "greater-gwinnett-championship-af9c6297d2",
	"name": "Greater Gwinnett Championship",
	"start_time": "2015-04-12 00:00:00 EDT",
	"reward_points": 300,
	"participants_count": 1,
	"attending": false,
	"timezone_name": "Eastern Time (US & Canada)",
	"timezone": {
		"name": "Eastern Time (US & Canada)",
		"offset": "-05:00",
		"abbreviation": "EDT",
		"moment_name": "America/New_York"
	},
	"joinable": true
},

*******/



- (id)initWithDictionary:(NSDictionary *)dictionary;


@end
