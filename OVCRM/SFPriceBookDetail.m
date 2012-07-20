//
//  SFPriceBookDetail.m
//  OVCRM
//
//  Created by Apple on 19/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SFPriceBookDetail.h"
#import "AppDelegate.h"

@implementation SFPriceBookDetail


-(NSString *) sfName{ return @"Product__c"; }
-(NSString *) sqlName{ return @"ProductPriceList"; }

-(NSDictionary *) schema{
	return [NSDictionary dictionaryWithObjectsAndKeys:
			@"LOOKUP", @"CreatedBy",
			@"LOOKUP", @"LastModifiedBy",
			@"DATETIME", @"CreatedDate",
			@"DATETIME", @"LastModifiedDate",
			@"TEXT", @"Name",
			@"NUMBER", @"X1st_Inv__c",
			@"NUMBER", @"X1st_Order__c",
			@"NUMBER", @"X2nd_Inv__c",
			@"NUMBER", @"X2nd_Order__c",
			@"NUMBER", @"X3th_Inv__c",
			@"NUMBER", @"X3th_Order__c",
			@"NUMBER", @"X4_Inv__c",
			@"NUMBER", @"X4_Order__c",
			@"TEXT", @"Active__c",
			@"PICKLIST", @"Brand__c",
			@"PICKLIST", @"Class__c",
			@"TEXT", @"Description__c",
			@"TEXT", @"Discount_Order__c",
			@"NUMBER", @"In_Stock__c",
			@"TEXT", @"IsDelMassCreate__c",
			@"TEXT", @"Is_Main__c",
			@"TEXT", @"List_Price__c",
			@"NUMBER", @"List_Price_Text__c",
			@"NUMBER", @"Number_Range__c",
			@"NUMBER", @"On_Shelf__c",
			@"NUMBER", @"On_Shelf_Price__c",
			@"NUMBER", @"Order__c",
			@"PICKLIST"	, @"Packaging__c",
			@"NUMBER"	, @"Pack_Size__c",
			@"TEXT"		, @"Price_Book__c",
			@"PICKLIST"	, @"Product_Category__c",
			@"TEXT"		, @"Product_Category_F__c",
			@"TEXT"		, @"Product_Code__c",
			@"PICKLIST"	, @"Product_Family__c",
			@"TEXT"		, @"Products_Database__c", // fk
			@"NUMBER"	, @"Report_3__c",
			@"PICKLIST"	, @"Reason_for_Return__c",
			@"NUMBER"	, @"Return_Quantity__c",
			@"NUMBER"	, @"Sales_Price__c",
			@"NUMBER"	, @"Shelf_Share__c",
			@"TEXT"		, @"Short_Name__c",
			@"NUMBER", @"SO__c",
			@"NUMBER", @"SO_1st__c",
			@"NUMBER", @"SO_2nd__c",
			@"NUMBER", @"SO_3th__c",
			@"NUMBER", @"SO_4__c",
			@"PICKLIST", @"Status__c",
			@"TEXT", @"Status_Promo__c",
			@"NUMBER", @"Weight__c",
			nil];
}

-(NSDictionary *) mapping{
	return [NSDictionary dictionaryWithObjectsAndKeys:
			@"Brand"			, @"Brand__c",
			@"ProductPrice_PK"	, @"Price_Book__c",
			@"ProductCode"		, @"Product_Code__c",
			@"ProductFamily"	, @"Product_Family__c",
			@"SalesPrice"		, @"Sales_Price__c",
			@"ProductName"		, @"Name", 
			@"ProductPrice_PK"	, @"Price_Book__c",
			nil];
}

-(void)sync:(id<OVSyncProtocal>)_controller{
    
	[super syncRecent:_controller];
}

@end
