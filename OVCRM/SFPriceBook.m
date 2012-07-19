//
//  SFPriceBook.m
//  OVCRM
//
//  Created by Apple on 14/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SFPriceBook.h"

@implementation SFPriceBook

-(NSString *) sfName{ return @"Price_Book__c"; }
-(NSString *) sqlName{ return @"ProductPrice"; }

-(NSDictionary *) schema{
	return [NSDictionary dictionaryWithObjectsAndKeys:
			@"Route_No__c", @"TEXT",
			@"CreatedBy", @"LOOKUP",
			@"LastModifiedBy", @"LOOKUP",
			@"CreatedDate", @"DATETIME",
			@"LastModifiedDate", @"DATETIME",
			
			@"Owner", @"LOOKUP",
			
			@"Name", @"TEXT",
			@"Account__c", @"LOOKUP",
			@"Active__c", @"TEXT",
			@"Currency_or__c", @"PICKLIST",
			@"Customer_Group__c", @"TEXT",
			@"Customer_Group_Sync__c", @"TEXT",
			@"Description__c", @"TEXT",
			@"Discount_Condition__c", @"TEXT",
			@"End_Date__c", @"TEXT",
			@"End_Promotion__c", @"TEXT",
			@"Line_Scale__c", @"TEXT",
			@"Material_Group__c", @"TEXT",
			@"Material_Group_5__c", @"TEXT",
			@"Rate_or_Value__c", @"NUMBER",
			@"Sales_Organization_1__c", @"TEXT",
			@"Sales_Organization_2__c", @"TEXT",
			@"Scale_Promotion__c", @"TEXT",
			@"Scale_Quantity__c", @"TEXT",
			@"Scale_Unit_of_Measurement__c", @"TEXT",
			@"Start_Date__c", @"TEXT",
			@"Start_Promotion__c", @"TEXT",
			@"Unit__c", @"TEXT",
			@"Unit_of_Measurement__c", @"TEXT", 
			nil];
}

-(NSDictionary *) mapping{
	return [NSDictionary dictionaryWithObjectsAndKeys:
			@"Sale_ID", @"Route_No__c",
			@"Price Book Name", @"Name",
			@"Account", @"Account__c",
			@"CurrencyOrPercent", @"Currency_or__c",
			@"Description ", @"Description__c",
			@"Discount Condition", @"Discount_Condition__c",
			@"Rate or Value", @"Rate_or_Value__c", 
			nil];
}

@end
