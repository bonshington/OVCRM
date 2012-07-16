//
//  OVDataseModel.m
//  OVCRM
//
//  Created by Apple on 16/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OVDataseProxy.h"
#import "NSObject+Reflection.h"

@implementation OVDataseProxy

-(NSMutableArray *)QueryData:(NSString *)sqlText{
	
	NSMutableArray *result = [NSMutableArray new];
	NSArray *select = [[[OVDatabase sharedInstance] executeQuery:sqlText] readToEnd];
	NSDictionary * properties = [self properties];
	
	[select enumerateObjectsUsingBlock:^(NSDictionary *entry, NSUInteger index, BOOL *stopRows){
	
		id instance = [NSClassFromString(NSStringFromClass(self.class)) new];
		
		[properties enumerateKeysAndObjectsUsingBlock:^(NSString *propName, NSString *propType, BOOL *stopParse){
			
			[instance setValue:[entry objectForKeyLike:propName] forKey:propName];
		}];
		
		[result addObject:instance];
	}];
	
	return result;
}

-(bool)OpenConnection{
	OVDatabase *db = [OVDatabase sharedInstance];
	
	if(!db.open)
	   [db open];
	
	return db.open;
}

-(bool)ExecSQL:(NSString *)addText parameterArray:(NSArray *)paramArr{
	
	OVDatabase *db = [OVDatabase sharedInstance];
	
	return [db executeUpdate:addText withArgumentsInArray:paramArr];
}

@end
