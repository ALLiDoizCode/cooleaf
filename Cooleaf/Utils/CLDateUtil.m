//
//  CLDateUtil.m
//  Cooleaf
//
//  Created by Haider Khan on 9/22/15.
//  Copyright © 2015 Nova Project. All rights reserved.
//

#import "CLDateUtil.h"

@implementation CLDateUtil

/**
 *  Convert unix time stamp or similar time string to human readable format
 *
 *  @param timeString - string from API
 *
 *  @return String (Example: Dec 31, 1969 07:33 PM)
 */
+ (NSString *)getReadableDateFromUnixString:(NSString *)timeString {
    
    // Convert to unix
    double unixTimeStamp = [timeString doubleValue];
    NSTimeInterval interval = unixTimeStamp;
    
    // Get the date object
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    
    // Initialize date formatter
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setLocale:[NSLocale currentLocale]];
    [df setTimeStyle:NSDateFormatterShortStyle];
    df.dateFormat = @"MMM dd, yyyy hh:mm a";
    
    // Return the readable string
    return [df stringFromDate:date];
}

@end
