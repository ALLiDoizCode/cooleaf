//
//  NPSettings.h
//  Cooleaf
//
//  Created by Haider Khan on 8/24/15.
//  Copyright (c) 2015 Nova Project. All rights reserved.
//

#import <Mantle.h>

@interface NPSettings : MTLModel <MTLJSONSerializing>

@property (nonatomic) BOOL *sendDailyDigest;
@property (nonatomic) BOOL *sendWeeklyDigest;

@end
