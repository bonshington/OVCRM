//
//  SFAR.m
//  OVCRM
//
//  Created by Sopon Srisummasheep on 7/22/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import "SFAR.h"

@implementation SFAR

-(NSString *) sfName{
	return @"Account_Receivable__c";
}

-(NSString *)sqlName{
	return @"Invoice";
}

-(NSDictionary *) schema{
	return [NSDictionary dictionaryWithObjectsAndKeys:
			@"TEXT"		, @"Name", 
			@"LOOKUP"	, @"CreatedBy", 
			@"DATETIME"	, @"CreatedDate", 
			@"LOOKUP"	, @"LastModifiedBy",
			@"DATETIME"	, @"LastModifiedDate", 
			
			@"TEXT", @"AccID__c",
			@"TEXT", @"AR_External_Id__c",
			@"NUMBER", @"Balance_Due__c",
			@"NUMBER", @"Credit_Balance__c",
			@"NUMBER", @"Credit_Limit__c",
			@"NUMBER", @"Customer_Discount__c",
			@"TEXT", @"Customer_Name__c",
			@"TEXT", @"Customer_No__c",
			@"NUMBER", @"Discount_Bath__c",
			@"TEXT", @"Discount_Order_Code_1__c",
			@"TEXT", @"Discount_Order_Code_2__c",
			@"TEXT", @"Discount_Order_Code_3__c",
			@"TEXT", @"Discount_Order_Code_4__c",
			@"NUMBER", @"Discount_Order_Rate_1__c",
			@"NUMBER", @"Discount_Order_Rate_2__c",
			@"NUMBER", @"Discount_Order_Rate_3__c",
			@"NUMBER", @"Discount_Percentage__c",
			@"NUMBER", @"Discount_Percentage_Amount__c",
			@"TEXT", @"Document_Date__c",
			@"TEXT", @"Document_No__c",
			@"TEXT", @"Document_Status__c",
			@"TEXT", @"Document_Time__c",
			@"TEXT", @"End_Period__c",
			@"TEXT", @"EventID__c",
			@"TEXT", @"Export__c",
			@"DATE", @"Invoice_Date__c",
			@"TEXT", @"Invoice_No__c",
			@"TEXT", @"Last_Modified__c",
			@"TEXT", @"Location__c",
			@"TEXT", @"MD_Transaction_Type_Code__c",
			@"NUMBER", @"Net_Total__c",
			@"TEXT", @"Note__c",
			@"TEXT", @"Over_Credit__c",
			@"NUMBER", @"Over_Credit_Amount__c",
			@"TEXT", @"Paid__c",
			@"TEXT", @"PO_Date__c",
			@"TEXT", @"PO_No__c",
			@"TEXT", @"Pricelist_No__c",
			@"TEXT", @"Reference__c",
			@"TEXT", @"Reference_Date__c",
			@"TEXT", @"Reference_No__c",
			@"TEXT", @"Salesman__c",
			@"TEXT", @"SalesNo__c",
			@"TEXT", @"Ship_Date__c",
			@"TEXT", @"Ship_No__c",
			@"TEX", @"Shipping_Address__c",
			@"NUMBER", @"Shop_Type_Discount__c",
			@"TEXT", @"Source_System__c",
			@"NUMBER", @"Sum_Net_Total__c",
			@"NUMBER", @"Total_After_Discount__c",
			@"NUMBER", @"Total_Before_Discount__c",
			@"NUMBER", @"Transaction_No__c",
			@"TEXT", @"Transaction_Type__c",
			@"TEXT", @"Van_No__c",
			@"NUMBER", @"VAT_Total__c",
			@"TEXT", @"VAT_Type__c",
			@"TEXT", @"Visit_Date__c",
			
			nil];
}

-(NSDictionary *) mapping{
	return [NSDictionary dictionaryWithObjectsAndKeys:
			@"Invoice_No"	, @"Invoice_No__c",
			@"Inv_DueDate"	, @"Invoice_Date__c",
			@"Inv_Total"	, @"Total_Before_Discount__c",
			@"Paid"			, @"Paid__c",
			@"Account_ID"	, @"AccID__c",
			nil];
}

-(void) sync:(id<OVSyncProtocal>)_controller{
	[super syncRecent:_controller];
}

@end
