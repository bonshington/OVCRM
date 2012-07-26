//
//  SFOrderDetail.m
//  OVCRM
//
//  Created by Apple on 14/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SFOrderDetail.h"

#import "AppDelegate.h"

@implementation SFOrderDetail

-(NSString *)sfName{ return @"Opportunity_Product__c";}
-(NSString *)sqlName {return @"Opportunity_Product__c";}

-(NSDictionary *)schema{
	return [NSDictionary dictionaryWithObjectsAndKeys:
			@"LOOKUP"	, @"CreatedBy", 
			@"DATETIME"	, @"CreatedDate", 
			@"LOOKUP"	, @"LastModifiedBy",
			@"DATETIME"	, @"LastModifiedDate", 
			
			@"TEXT"		, @"Account_ID__c", //fk
			@"NUMBER"	, @"Allocation__c", 
			@"PICKLIST"	, @"Brand__c", 
			@"PICKLIST"	, @"Class__c", 
			@"TEXT"		, @"DeleteEx__c", 
			@"NUMBER"	, @"Discount_Order__c", 
			@"TEXT"		, @"Is_Main__c",  //
			@"NUMBER"	, @"List_Price__c", 
			@"NUMBER", @"Number_Range__c", 
			@"TEXT", @"Order_Taking__c",  //fk
			@"TEXT", @"Premium__c", 
			@"PICKLIST", @"Product_Category__c", 
			@"TEXT", @"Product_Code__c", 
			@"TEXT", @"Product_Code_Formular__c", 
			@"PICKLIST", @"Product_Family__c", 
			@"TEXT", @"Product_Group__c", 
			@"TEXT", @"Product_Name__c", 
			@"TEXT", @"Product__c", 
			@"TEXT", @"Products_Database_ID__c", // fk
			@"TEXT", @"Product_Type__c", 
			@"NUMBER", @"Quantity__c", 
			@"PICKLIST", @"Quantity_Type__c", 
			@"NUMBER", @"Sales_Price__c", 
			@"TEXT", @"Source_System__c", 
			@"TEXT", @"Status__c", 
			@"NUMBER", @"Target__c", 
			@"NUMBER", @"Total_Price__c", 
			@"NUMBER", @"Total_Price_Text__c",
			nil];
}

-(NSDictionary *)mapping{
	return [NSDictionary new];
}

-(void) sync:(id<OVSyncProtocal>)_controlller{
	
	[super sync:_controlller where:nil];
	
	
	//[super sync:_controlller where:[NSString stringWithFormat:@"Account_ID__c in (select Id from Account where Route_No__c = '%@')", [AppDelegate sharedInstance].routeId]];
	
}

@end
