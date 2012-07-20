//
//  SFSalesTalk.m
//  OVCRM
//
//  Created by Apple on 14/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SFSalesTalk.h"
#import "AppDelegate.h"

@implementation SFSalesTalk

-(NSString *) sfName{
	return @"Sales_Talk__c";
}

-(NSString *) sqlName{
	return @"SaleTalk";
}

-(NSDictionary *) schema{
	return [NSDictionary dictionaryWithObjectsAndKeys:
			
			@"TEXT", @"Name",
			@"LOOKUP", @"CreatedBy",
			@"LOOKUP", @"LastModifiedBy",
			@"DATETIME", @"CreatedDate",
			@"LOOKUP", @"LastModifiedBy",
			@"DATETIME", @"LastModifiedDate",
			
			@"TEXT", @"Account_Name__c", 
			@"TEXT", @"Event_ID__c", 
			@"TEXT", @"Sales_Talk__c", 
			@"TEXT", @"Source_System__c", 
			
			nil];
}

-(NSDictionary *) mapping{
	return [NSDictionary dictionaryWithObjectsAndKeys:
			@"saleTalk", @"Sales_Talk__c", 
			@"plan_ID", @"Event_ID__c",
			nil];
}

-(void)sync:(id<OVSyncProtocal>)_controller{
    
	NSString *lastSyncDate = [[AppDelegate sharedInstance].user objectForKey:@"lastSyncDate"];
	
	[super sync:_controller where:[NSString stringWithFormat:@"CreatedDate >= %@T00:00:00z and LastModifiedDate >= %@T00:00:00z", lastSyncDate, lastSyncDate]];
}

@end
