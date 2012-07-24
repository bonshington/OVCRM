//
//  SFOrderTaking.m
//  OVCRM
//
//  Created by Apple on 14/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SFOrderTaking.h"

@implementation SFOrderTaking

-(NSString *)sfName{
	return @"Order_Taking__c";
}

-(NSString *)sqlName{
	return @"Order_Taking__c";
}

-(NSDictionary *)schema{
	return [NSDictionary dictionaryWithObjectsAndKeys:
			@"TEXT", @"Account_Name__c",
			@"TEXT", @"Account_Number__c",
			@"NUMBER", @"Amount__c",
			@"NUMBER", @"Amount_Text__c",
			@"TEXT", @"Call_Visit_Target__c",
			@"TEXT", @"Close_Date__c",
			@"TEXT", @"Coupon_Issued__c",
			@"TEXT", @"Description__c",
			@"TEXT", @"EventID__c",
			@"NUMBER", @"Month__c",
			@"TEXT", @"Month_Formula__c",
			@"TEXT", @"Order_Taking_Name__c",
			@"NUMBER", @"Periods_of_Order__c",
			@"TEXT", @"Quarter_Formula__c",
			@"TEXT", @"Salesman__c",
			@"TEXT", @"Source_System__c",
			@"PICKLIST", @"Stage__c",
			@"NUMBER", @"Unit_by_Order__c",
			@"NUMBER", @"Year__c",
			@"NUMBER", @"YTD_LY__c",
			@"NUMBER", @"YTD_TY__c",
			nil];
}

-(NSDictionary *)mapping{
	return [NSDictionary new];
}

-(void)sync:(id<OVSyncProtocal>)_controller{
	[super sync:_controller where:[NSString stringWithFormat:@""]];
}

@end
