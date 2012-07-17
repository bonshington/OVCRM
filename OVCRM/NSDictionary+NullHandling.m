//
//  NSDictionary+NullHandling.m
//  OVCRM
//
//  Created by Apple on 05/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NSDictionary+NullHandling.h"

@implementation NSDictionary (NullHandling)

- (id)emptyIfNull:(id)key{
    
    id test = [self objectForKey:key];
    
    if(test == nil || test == [NSNull null] || test == NULL)
        return @"";
    else {
        return test;
    }
}

-(id) replaceNilValueWithEmpty{
    
    for(id key in [self allKeys]){
        if([self objectForKey:key] == nil)
            [self setValue:@"" forKey:key];
    }
    
    return self;
}

-(id) coalesce:(id)keys, ... NS_REQUIRES_NIL_TERMINATION{
	
	va_list args;
	va_start(args, keys);
	
	NSString *k = va_arg(args, NSString*);
	
	while(k != nil) {
		
		if([self objectForKey:k] != nil)
			return [self objectForKey:k];
		
		k = va_arg(args, NSString*);
	}
	va_end(args);
	
	return nil;
}

@end
