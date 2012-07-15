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

@end
