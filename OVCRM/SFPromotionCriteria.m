//
//  SFPromotionCriteria.m
//  OVCRM
//
//  Created by Apple on 23/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SFPromotionCriteria.h"
#import "AppDelegate.h"

@implementation SFPromotionCriteria

-(NSString *)sfName{
	return @"Promotion_Criteria__c";
}

-(NSString *)sqlName{
	return @"Promotion_Criteria__c";
}

-(NSDictionary *)schema{
	return [NSDictionary dictionaryWithObjectsAndKeys:
			
			@"TEXT"		, @"Products_Database__c", // fk
			@"TEXT"		, @"Promotion__c", // fk
			@"NUMBER"	, @"Amount__c",
			@"NUMBER"	, @"Quantity__c", 
			
			nil];
}

-(NSDictionary *)mapping{
	return [NSDictionary new];
}

-(void) sync:(id<OVSyncProtocal>)_controller{
	return [super syncRecent:_controller];
}

+(NSArray *)current{
	return [[[OVDatabase sharedInstance] executeQuery:
	@"select * from 	Promotion_Criteria__c	\
	where 	Promotion__c in (select Id from Promotion__c	\
							 where start_date__c <= date('now') and date('now') <= end_date__c	\
						)	\
			 "] readToEnd];
}

@end
