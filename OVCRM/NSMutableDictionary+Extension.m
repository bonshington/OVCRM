//
//  NSMutableDictionary+Extension.m
//  OVCRM
//
//  Created by Sopon Srisummasheep on 7/14/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import "NSMutableDictionary+Extension.h"

@implementation NSMutableDictionary (Extension)

-(void) changeKeyFrom:(id)oldKey to:(id)newKey{
	
	id val = [self objectForKey:oldKey];
	
	[self removeObjectForKey:oldKey];
	
	[self setObject:val forKey:newKey];
}

@end
