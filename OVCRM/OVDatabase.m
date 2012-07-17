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
        
        NSString *docsDir;
        NSArray *dirPaths;
        
        // Get the documents directory
        dirPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        docsDir = [dirPaths objectAtIndex:0];
        
        // Build the path to the database file
        NSString *databasePath = [[NSString alloc] initWithString: [docsDir stringByAppendingPathComponent: [NSString stringWithFormat:@"%@.db", [SFRestAPI sharedInstance].coordinator.credentials.userId]]];
        
		NSLog(databasePath);
		
        app.db = [self initWithPath:databasePath];
        app.db.logsErrors = YES;
        
        [app.db open];
		
		
		/* init tables */
		FMResultSet *result = [app.db executeQuery:@"select 1 from Parameter limit 1"];
		
		BOOL valid = result != nil && result.hasAnotherRow;
		
		[result close];
		
		
		if (!valid){    
			NSArray *initScript = [[NSArray alloc] initWithObjects:
								   @"create table if not exists Parameter(tag text, key text, label text, primary key (tag, key))", 
								   @"insert or replace into Parameter(tag, key, val) values('CONFIG', 'LAST_SYNC', '2000-01-01')",
								   @"create table if not exists Upload(pk INTEGER PRIMARY KEY AUTOINCREMENT, sObject TEXT, Id TEXT, createTime TEXT, syncTime TEXT, json TEXT)",
								   nil];
			
			[app.db beginTransaction];
			
			for (NSString *script in initScript) {
				[app.db executeUpdate:script];
			}
			
			[app.db commit];
		}
		
		
		//[app.db executeUpdate:@"drop table Event"];
    }  
    else{
        self = app.db;
    }
    
    return self;
}

-(void) sfInsertInto:(NSString *)table withData:(NSDictionary *)data{
	
	
	NSMutableDictionary *transform = [[NSMutableDictionary alloc] initWithDictionary:data];
	NSString *objectId = [transform coalesce:@"Id", @"pk", @"PK", @"Pk", @"pK", @"id", @"ID"];
	[transform removeObjectsForKeys:[NSArray arrayWithObjects:@"Id", @"pk", @"PK", @"Pk", @"pK", @"id", @"ID", nil]];
	
	// get sfname
	NSString *object = [sObject SFNameForSqlTable:table];
	
	
	// mapping
	[[sObject mappingForSObject:object] enumerateKeysAndObjectsUsingBlock:^(NSString *sf, NSString *sql, BOOL *stop){
		[transform changeKeyFrom:sql to:sf];
	}];
	
	
	// insert to db
	NSString *serialized = [SFJsonUtils JSONRepresentation:data];
	[self executeUpdate:@"insert into Upload(sObject, Id, createTime, json) values(?, ?, datetime('now', 'localtime'), ?)", object, objectId, serialized];
	
	
	// update badge
	[[AppDelegate sharedInstance] refreshUploadTask];

}

+ (OVDatabase *) sharedInstance{

    return [AppDelegate sharedInstance].db;
}

@end
