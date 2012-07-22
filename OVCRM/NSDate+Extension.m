//
//  NSDate+Extension.m
//  OVCRM
//
//  Created by Sopon Srisummasheep on 7/14/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)

-(NSString *) format:(NSString *)formatString{

	NSDateFormatter* dateFormatter = [NSDateFormatter new];
	[dateFormatter setDateFormat:formatString];
	
	return [dateFormatter stringFromDate:self];
}

-(NSString *) SFString{
	
	NSDateFormatter* timeFormatter = [NSDateFormatter new];
	[timeFormatter setDateFormat:@"HH:mm:ss"];
	
	return [NSString stringWithFormat:@"%@T%@+07:00", [self format:@"yyyy-MM-dd"], [timeFormatter stringFromDate:self]];
}

-(NSDate *) midnight{
	
	NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    [calendar setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:7 * 3600]];
	
    NSDateComponents *dateComponents = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit
                                                   fromDate:self];
    [dateComponents setHour:0];
    [dateComponents setMinute:0];
    [dateComponents setSecond:0];
	
    return [calendar dateFromComponents:dateComponents];
}

@end
