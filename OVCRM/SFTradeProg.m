//
//  SFTradeProg.m
//  OVCRM
//
//  Created by Sopon Srisummasheep on 7/21/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import "SFTradeProg.h"

@implementation SFTradeProg

-(NSString *) sfName{
	return @"Trade_Program_Execution__c";
}

-(NSString *) sqlName{
	return @"Trade_Program_Execution__c";
}

-(NSDictionary *) schema{
	return [NSDictionary dictionaryWithObjectsAndKeys:
			@"TEXT"		, @"Name", 
			@"LOOKUP"	, @"CreatedBy", 
			@"DATETIME"	, @"CreatedDate", 
			@"LOOKUP"	, @"LastModifiedBy",
			@"DATETIME"	, @"LastModifiedDate", 
			
			@"TEXT", @"Account__c",
			@"TEXT", @"Trade_Program_Result__c",
			@"TEXT", @"Event_ID__c",
			
			nil];
}

-(NSDictionary *) mapping{
	return [NSDictionary new];
}

-(void)sync:(id<OVSyncProtocal>)_controller{
    
	[super syncRecent:_controller];
}

@end
