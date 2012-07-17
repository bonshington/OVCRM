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
			
			if([entry objectForKeyLike:propName] != nil)
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
	
	NSArray *phrase = [[addText lowercaseString] componentsSeparatedByString:@") values ("];
	OVDatabase *db = [OVDatabase sharedInstance];
	
	NSString *intoClause = [[[phrase objectAtIndex:0] componentsSeparatedByString:@"("] objectAtIndex:1];
	
	
	// parse to dictionary ////////////////////////
	
	NSMutableDictionary *parse = [NSMutableDictionary new];
	
	[[intoClause componentsSeparatedByString:@","] enumerateObjectsUsingBlock:^(NSString * col, NSUInteger index, BOOL *stop){
		
		col = [col stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@" "]];
		
		[parse setObject:[paramArr objectAtIndex:index] forKey:col];
	}];
	
	[db sfInsertInto:[self sqlName] withData:parse];
	////////////////////////////////////////////////
	
	return [db executeUpdate:addText withArgumentsInArray:paramArr];
}


-(NSString *)GetMaxRnNo{
	
	OVDatabase *db = [OVDatabase sharedInstance];
	
	if(!db.open)
		[db open];
	
	NSArray *result = [[db executeQuery:[NSString stringWithFormat:@"select Id from %@ order by Id desc limit 1", [self sqlName]]] readToEnd];
	
	return [[result objectAtIndex:0] objectForKey:@"Id"];
	
}

@end
