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
	[timeFormatter setDateFormat:@"HH:mm:sss"];
	
	return [NSString stringWithFormat:@"%@T%@+07:00", [self format:@"yyyy-MM-dd"], [timeFormatter stringFromDate:self]];
}

@end
