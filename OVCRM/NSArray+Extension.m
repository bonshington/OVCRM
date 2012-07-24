//
//  NSArray+Extension.m
//  OVCRM
//
//  Created by Apple on 10/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NSArray+Extension.h"
#import "RKObjectSerializer.h"

@implementation NSArray (Extension)

-(NSString *)toJson{
    
    NSMutableString *json = [NSMutableString new];
    
    [json appendString:@"["];
    
    [self enumerateObjectsUsingBlock:^(NSDictionary *entry, NSUInteger i, BOOL *stop){
    
        if(i > 0){
            [json appendString:@","];
        }
        
        [json appendString:@"{"];
        
        NSArray *keys = [entry allKeys];
        
        
        
        [keys enumerateObjectsUsingBlock:^(NSString *key, NSUInteger j, BOOL *_stop){
        
            id value = [entry objectForKey:key];
            
            if(j > 0){
                [json appendString:@","];
            }
            
            if(value == nil){
                [json appendFormat:@"\"%@\":\"\"", key];
            }
            else if([value isKindOfClass:[NSString class]] && ((NSString *)value).length > 0){
                [json appendFormat:@"\"%@\":\"%@\"", key, [(NSString *)value stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""]];
            }
            else{
                [json appendFormat:@"\"%@\":\"%@\"", key, value];
            }

        }];
        
        [json appendString:@"}"];
    }];
    
    [json appendString:@"]"];
    
    return json;
}

-(id) objectAtIndex:(NSUInteger)index forKey:(id)key{
	return [[self objectAtIndex:index] objectForKey:key];
}

-(NSDictionary *) dictionaryFromObjectForKey:(id)key{
	
	NSMutableDictionary *result = [NSMutableDictionary new];
	
	[self enumerateObjectsUsingBlock:^(NSDictionary * element, NSUInteger index, BOOL *stop){
		[result setObject:element forKey:[element objectForKey:key]];
	}];
	
	return result;
}

@end
