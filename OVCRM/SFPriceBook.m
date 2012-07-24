//
//  SFPriceBook.m
//  OVCRM
//
//  Created by Apple on 14/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SFPriceBook.h"
#import "AppDelegate.h"

@implementation SFPriceBook

-(NSString *) sfName{ return @"Price_Book__c"; }
-(NSString *) sqlName{ return @"ProductPrice"; }

-(NSDictionary *) schema{
	return [NSDictionary dictionaryWithObjectsAndKeys:

			@"LOOKUP"	,@"CreatedBy",
			@"LOOKUP"	,@"LastModifiedBy",
			@"DATETIME"	,@"CreatedDate",
			@"DATETIME"	,@"LastModifiedDate",
			//@"LOOKUP",@"Owner",
			@"TEXT"		,@"Name",
			@"TEXT"		,@"Account__c",
			@"TEXT"		,@"Active__c",
			@"TEXT"		,@"Currency_or__c",
			@"TEXT"		,@"Customer_Group__c",
			@"TEXT"		,@"Customer_Group_Sync__c",
			@"TEXT"		,@"Description__c",
			@"TEXT"		,@"Discount_Condition__c",
			@"TEXT"		,@"End_Date__c",
			@"TEXT"		,@"End_Promotion__c",
			@"TEXT"		,@"Line_Scale__c",
			@"TEXT"		,@"Material_Group__c",
			@"TEXT"		,@"Material_Group_5__c",
			@"NUMBER"	,@"Rate_or_Value__c",
			@"TEXT"		,@"Sales_Organization_1__c",
			@"TEXT"		,@"Sales_Organization_2__c",
			@"TEXT"		,@"Scale_Promotion__c",
			@"TEXT"		,@"Scale_Quantity__c",
			@"TEXT"		,@"Scale_Unit_of_Measurement__c",
			@"TEXT"		,@"Start_Date__c",
			@"TEXT"		,@"Start_Promotion__c",
			@"TEXT"		,@"Unit__c",
			@"TEXT"		,@"Unit_of_Measurement__c",
			
			@"PICKLIST"	, @"Status__c",
			nil];
}

-(NSDictionary *) mapping{
	return [NSDictionary dictionaryWithObjectsAndKeys:
			@"PriceBookName", @"Name",
			@"Account"		, @"Account__c",
			@"CurrencyOrPercent", @"Currency_or__c",
			@"Description "	, @"Description__c",
			@"DiscountCondition", @"Discount_Condition__c",
			@"RateOrValue"	, @"Rate_or_Value__c", 
			nil];
}

-(void)sync:(id<OVSyncProtocal>)_controller{
    
	[super syncRecent:_controller];
}

@end
