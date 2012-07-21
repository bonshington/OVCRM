//
//  FMResultSet+Extension.m
//  OVCRM
//
//  Created by Apple on 10/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FMResultSet+Extension.h"

@implementation FMResultSet (Extension)

-(NSArray *) readToEnd{
    
    NSMutableArray *result = [NSMutableArray new];
    
    while([self next]){
        [result addObject:[self resultDictionary]];
    }
    
    [self close];
    
    return result;
    
}

-(NSDictionary *) readToEndBy:(NSString *)column{
	
	NSMutableDictionary *result = [NSMutableDictionary new];
	
	while([self next]){
        [result setValue:[self resultDictionary] forKey:[self stringForColumn:column]];
    }
    
    [self close];
    
    return result;
}

@end
