//
//  SFCompetitive.m
//  OVCRM
//
//  Created by Sopon Srisummasheep on 7/21/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import "SFCompetitive.h"

@implementation SFCompetitive

-(NSString *) sfName{
	return @"Competitive_Activities__c";
}

-(NSString *) sqlName{
	return @"Competitive_Activities__c";
}

-(NSDictionary *) schema{
	return [NSDictionary dictionaryWithObjectsAndKeys:
			@"TEXT"		, @"Name", 
			@"LOOKUP"	, @"CreatedBy", 
			@"DATETIME"	, @"CreatedDate", 
			@"LOOKUP"	, @"LastModifiedBy",
			@"DATETIME"	, @"LastModifiedDate", 
			
			@"TEXT", @"Account__c",
			@"TEXT", @"Competitor_s_Product__c",
			@"TEXT", @"Event_ID__c",
			
			@"TEXT", @"iFab_Information__c",
			@"TEXT", @"Promotion_Information__c",
			@"TEXT", @"Company_Information__c",
			nil];
}

-(NSDictionary *) mapping{
	return [NSDictionary new];
}

-(void)sync:(id<OVSyncProtocal>)_controller{
    
	[super syncRecent:_controller];
}

@end
