//
//  OVDataWrapper.m
//  OVCRM
//
//  Created by Apple on 03/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OVDatabase.h"
#import "AppDelegate.h"

#import "SFJsonUtils.h"


@implementation OVDatabase

-(id) init{
    
    AppDelegate *app = [AppDelegate sharedInstance];
    
    if(app.db == nil){
        
        // Get the documents directory
        NSArray *dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *docDir = [dirPaths objectAtIndex:0];
        NSString *dbFile = [NSString stringWithFormat:@"%@.db", [SFRestAPI sharedInstance].coordinator.credentials.userId];
		
		
        // Build the path to the database file
        NSString *databasePath = [docDir stringByAppendingPathComponent: dbFile];
        
		NSLog(@"DB:> %@%@", docDir, dbFile);
		
        app.db = [self initWithPath:databasePath];
        app.db.logsErrors = YES;
        
        [app.db open];
		
		
		/* inject script */
		//[app.db executeUpdate:@"drop table ProductPriceList"];
		//[app.db executeUpdate:@"delete from Upload"];
		//[app.db executeUpdate:@"alter table Upload add column planId text"];
		//[app.db executeUpdate:@"update Upload set planId = '00UO0000001gierMAA'"];
		/*****************/
		
		/* init tables */
		FMResultSet *result = [app.db executeQuery:@"select 1 from Parameter limit 1"];
		
		BOOL valid = result != nil && [result next];
		
		[result close];
		
		
		if (!valid){    
			NSArray *initScript = [[NSArray alloc] initWithObjects:
								   @"create table if not exists Parameter(tag text, key text, label text, primary key (tag, key))", 
								   @"insert or replace into Parameter(tag, key, label) values('CONFIG', 'LAST_SYNC', '2000-01-01')",
								   @"create table if not exists Upload(pk INTEGER PRIMARY KEY AUTOINCREMENT, sObject TEXT, Id TEXT, planId text, createTime TEXT, syncTime TEXT, json TEXT)",
								   nil];
			
			[app.db beginTransaction];
			
			for (NSString *script in initScript) {
				[app.db executeUpdate:script];
			}
			
			[app.db commit];
		}
		
    }  
    else{
        self = app.db;
    }
    
    return self;
}

-(void) sfInsertInto:(NSString *)table withData:(NSDictionary *)data{
	
	
	NSMutableDictionary *transform = [[NSMutableDictionary alloc] initWithDictionary:data];
	
	NSString *objectId = [transform coalesce:@"Id", @"pk", @"PK", @"Pk", @"pK", @"id", @"ID", nil];
	
	[transform removeObjectsForKeys:[NSArray arrayWithObjects:@"Id", @"pk", @"PK", @"Pk", @"pK", @"id", @"ID", nil]];
	
	
	// get sfname
	NSString *object = [sObject SFNameForSqlTable:table];
	
	
	// mapping
	NSDictionary *mapping = [sObject mappingForSObject:object];
	
	[mapping enumerateKeysAndObjectsUsingBlock:^(NSString *sf, NSString *sql, BOOL *stop){
		
		if([[transform allKeys] containsObject:sql])
			[transform changeKeyFrom:sql to:sf];
	}];
	
	
	// insert to db
	NSString *serialized = [SFJsonUtils JSONRepresentation:transform];
	
	[self executeUpdate:@"insert into Upload(sObject, Id, planId, createTime, json) values(?, ?, ?, datetime('now', 'localtime'), ?)", object, objectId, [[AppDelegate sharedInstance].checkin objectForKey:@"PlanId"], serialized];
	
	
	// update badge
	[[AppDelegate sharedInstance] refreshUploadTask];

}

+ (OVDatabase *) sharedInstance{

    return [AppDelegate sharedInstance].db;
}

@end
