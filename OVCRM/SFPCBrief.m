//
//  SFPCBrief.m
//  OVCRM
//
//  Created by Apple on 14/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SFPCBrief.h"
#import "AppDelegate.h"

@implementation SFPCBrief

-(NSString *) sfName{
	return @"PC_Brief__c";
}

-(NSString *) sqlName{
	return @"PCBrief";
}

-(NSDictionary *) schema{
	return [NSDictionary dictionaryWithObjectsAndKeys:
			
			@"TEXT"		, @"Name",
			@"LOOKUP"	, @"CreatedBy",
			@"DATETIME"	, @"CreatedDate",
			@"LOOKUP"	, @"LastModifiedBy",
			@"DATETIME"	, @"LastModifiedDate",
			
			@"TEXT", @"Account_Name__c",
			@"TEXT", @"Attachment__c",
			@"TEXT", @"Display_Information__c",
			@"TEXT", @"Event_ID__c",
			@"TEXT", @"Offtake_Information__c",
			@"TEXT", @"PC_Merchandiser_Feedback__c",
			@"TEXT", @"PC_Brief__c",
			@"TEXT", @"Pricing_Information__c",
			@"TEXT", @"Source_System__c",
			
			//@"TEXT", @"",
			nil];	
}

-(NSDictionary *) mapping{
	return [NSDictionary dictionaryWithObjectsAndKeys:
			@"plan_ID", @"Event_ID__c", 
			@"pcBrief", @"PC_Brief__c",
			nil];
}

-(void)sync:(id<OVSyncProtocal>)_controller{
    
	NSString *lastSyncDate = [[AppDelegate sharedInstance].user objectForKey:@"lastSyncDate"];
	
	[super sync:_controller where:[NSString stringWithFormat:@"CreatedDate >= %@T00:00:00z and LastModifiedDate >= %@T00:00:00z", lastSyncDate, lastSyncDate]];
}

@end
