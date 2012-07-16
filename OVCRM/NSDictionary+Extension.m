//
//  NSDictionary+Extension.m
//  OVCRM
//
//  Created by Apple on 10/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NSDictionary+Extension.h"

@implementation NSDictionary (Extension)

-(id)objectAtIndex:(NSInteger)index{
    
    return [self objectForKey:[[self allKeys] objectAtIndex:index]];
}

-(id)objectForKeyLike:(NSString *)key{
	
	for(NSString *k in [self allKeys]){
		if([k caseInsensitiveCompare:key] == NSOrderedSame){
			return [self objectForKey:k];
		}
	}
	
	return  nil;
}

@end
