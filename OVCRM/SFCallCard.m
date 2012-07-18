//
//  SFCallCard.m
//  OVCRM
//
//  Created by Sopon Srisummasheep on 7/11/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import "SFCallCard.h"
#import "AppDelegate.h"

@implementation SFCallCard

-(NSString *) sfName{ return @"Call_Card__c"; }
-(NSString *) sqlName{ return @"CallCard"; }

-(NSDictionary *)schema{
	return [NSDictionary dictionaryWithObjectsAndKeys:
			@"TEXT"		, @"Name",
            
			@"LOOKUP"	, @"CreatedBy",
            @"DATETIME"	, @"CreatedDate", 
			
			@"LOOKUP"	, @"LastModifiedBy",
			@"DATETIME"	, @"LastModifiedDate", 
			
			@"LOOKUP"	, @"Owner",
			
			@"TEXT"		, @"Account__c",
			@"TEXT"		, @"Checking_Date__c",
			@"NUMBER"	, @"Periods_of_Stock__c",
			@"TEXT"		, @"Source_System__c",
			
			nil];
}

-(NSDictionary *)mapping{
	
	return [NSDictionary dictionaryWithObjectsAndKeys:
			@"Account_ID", @"Account__c", 
			@"CS_Date", @"Checking_Date__c",
			nil];
}

-(void)sync:(id<OVSyncProtocal>)_controller{
    
	NSString *lastSyncDate = [[AppDelegate sharedInstance].user objectForKey:@"lastSyncDate"];
	
	[super sync:_controller 
		  where:[NSString stringWithFormat:
				 @"Account__c in (select Id from Account where Route_no__c = '%@')"// and CreatedDate >= %@T00:00:00z and LastModifiedDate >= %@T00:00:00z"
				 , [[AppDelegate sharedInstance].user objectForKey:@"route"]
				 , lastSyncDate
				 , lastSyncDate
				 ]
	 ];
}

@end
