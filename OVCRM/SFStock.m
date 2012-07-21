//
//  SFStock.m
//  OVCRM
//
//  Created by Apple on 12/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SFStock.h"
#import "AppDelegate.h"

@implementation SFStock

-(NSString *)sfName{ return @"Stock__c";}
-(NSString *)sqlName{ return @"Stock__c";}


-(NSDictionary *)schema{
    return [NSDictionary dictionaryWithObjectsAndKeys:
            @"LOOKUP", @"CreatedBy",
            @"DATETIME", @"CreatedDate", 
            @"LOOKUP", @"LastModifiedBy",
            @"DATETIME", @"LastModifiedDate",
			@"TEXT", @"AccountID__c",
			@"TEXT", @"Call_Card__c",
			@"TEXT", @"DeleteEX__c",
			@"NUMBER", @"In_Stock__c",
			//@"NUMBER", @"Month__c",
			@"NUMEBR", @"Quantity_Remain__c",
			@"TEXT", @"Periods_of_Stock__c",
			@"TEXT", @"Products__c",
			@"TEXT", @"Source_System__c",
			@"TEXT", @"Stock_Update__c",
			//@"NUMBER", @"Year__c",
			@"TEXT", @"Name",
			@"TEXT", @"prod_db_id__c",
			nil];
	
}

-(NSDictionary *)mapping{
	return [NSDictionary new];
			//@"Product_Name", @"Name",
			//@"OnShelf", @"Quantity_Remain__c",
			//@"InStock", @"In_Stock__c",
			//@"CallCard_PK", @"Call_Card__c",
			//@"Stock", @"Stock__c",
			//nil];
}

-(void)sync:(id<OVSyncProtocal>)_controller{
    
	NSString *myRoute = [[AppDelegate sharedInstance].user objectForKey:@"route"];
	NSString *lastSyncDate = [[AppDelegate sharedInstance].user objectForKey:@"lastSyncDate"];
	
	[super sync:_controller where:[NSString stringWithFormat:@"AccountId__c in (select Id from Account where Route_no__c = '%@') and CreatedDate >= %@T00:00:00z and LastModifiedDate >= %@T00:00:00z", myRoute, lastSyncDate, lastSyncDate]];
	
}

@end
