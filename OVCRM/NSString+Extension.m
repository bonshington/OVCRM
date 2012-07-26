//
//  NSString_Extension.m
//  OVCRM
//
//  Created by Apple on 05/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NSString+Extension.h"
#import "AppDelegate.h"

@implementation NSString(Extension)

-(NSString *) stringByReplace:(NSArray *)array 
                   withString:(NSString *)withString{
    
    NSString *result = [NSString stringWithString:self];
    
    for(NSString *each in array){
        result = [result stringByReplacingOccurrencesOfString:each withString:withString];
    }
    
    return result;
}

-(NSString *)htmlEncode{
    
    if(self == nil || self.length == 0)
        return @"";
    
    NSString *encoded = [self stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"];
    
    encoded = [encoded stringByReplacingOccurrencesOfString:@"\"" withString:@"&quot;"];
    encoded = [encoded stringByReplacingOccurrencesOfString:@"'" withString:@"&apos;"];
    
    encoded = [encoded stringByReplacingOccurrencesOfString:@"<" withString:@"&lt;"];
    encoded = [encoded stringByReplacingOccurrencesOfString:@">" withString:@"&gt;"];
    
    return encoded;
}

+(NSString *)guid{
	
	NSDictionary *data = [AppDelegate sharedInstance].checkin;
	
	if(data == nil || [data objectForKey:@"myself"] == nil){
		CFUUIDRef newUniqueId = CFUUIDCreate(kCFAllocatorDefault);
		NSString * uuidString = (__bridge_transfer NSString*)CFUUIDCreateString(kCFAllocatorDefault, newUniqueId);
		CFRelease(newUniqueId);
		
		return [NSString stringWithFormat:@"-%@", uuidString];
	}
	else{
	
		return [NSString stringWithFormat:
				@" %@ (%@ - %@)"
				, [[data objectForKey:@"AccountData"] objectForKey:@"Name"]
				, [data objectForKey:@"myself"]
				, [(NSDate *)[data objectForKey:@"time"] format:@"dd MMM yyyy, HH:mm"]
				];
	}
}


-(BOOL)contains:(NSString *)text{
	
	NSRange textRange =[[self lowercaseString] rangeOfString:[text lowercaseString]];
	
	return textRange.location != NSNotFound;
}

-(BOOL) isInteger{
	NSScanner *sc = [NSScanner scannerWithString:self];
	if ( [sc scanInteger:NULL] )
	{
		return [sc isAtEnd];
	}
	return NO;
}

@end
