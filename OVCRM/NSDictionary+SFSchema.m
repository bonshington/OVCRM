//
//  NSDictionary+SFSchema.m
//  OVCRM
//
//  Created by Apple on 06/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NSDictionary+SFSchema.h"
#import "NSArray+LINQ.h"
#import "AppDelegate.h"

@implementation NSDictionary (SFSchema)


-(NSString *) extractObjectForKey:(NSString *)key withProperty:(NSString *)prop{
    
    id value = [self objectForKey:key];
    
    if([value isKindOfClass:[NSDictionary class]]){
        
        return [value objectForKey:prop];
    }
    else {
        NSArray *phrases = [[value componentsSeparatedByString:@"\n"] where:^BOOL(NSString * entry){
            
            return [[entry stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@" "]] hasPrefix:[NSString stringWithFormat:@"%@ = ", prop]];
        }];
        
        return [[[[phrases objectAtIndex:0] componentsSeparatedByString:@" = "] objectAtIndex:1] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"\";"]];
    }
    
}

-(NSArray *)extractSFValueFrom:(NSDictionary *)json{
    
    NSMutableArray *args = [NSMutableArray new];
    
    [args addObject:[json objectForKey:@"Id"]];
    
    [self enumerateKeysAndObjectsUsingBlock:^(NSString *col, NSString *type, BOOL* stop){
    
        id value = [json objectForKey:col];
        
        if(value == nil || value == [NSNull null]){            
            [args addObject:@""];
        }
        else if([type isEqualToString:@"LOOKUP"]){
            
            [args addObject:[json extractObjectForKey:col withProperty:@"Name"]];
        } 
        else if([type isEqualToString:@"FK"]){
            [args addObject:[json extractObjectForKey:col withProperty:@"Id"]];
        } 
        else if([type isEqualToString:@"DATETIME"]){
			
			//NSLog(@"parsing: %@", value);
			
			if(((NSString *)value).length > 10){
			
				NSString *dt = [[[NSString stringWithFormat:@"%@", value] stringByReplacingOccurrencesOfString:@"T" withString:@" "] substringToIndex:19];
			
				NSDate *localTime = [[[AppDelegate sharedInstance].sqlFormat dateFromString:dt] dateByAddingTimeInterval:7 * 60 * 60];
			
				[args addObject:[localTime format:@"yyyy-MM-dd HH:mm:ss"]];
			}
			else {
				[args addObject:value];
			}
        }
        else {
            [args addObject:value];
        }
    }];
    
    return args;
}

@end
