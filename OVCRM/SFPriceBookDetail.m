//
//  SFPriceBookDetail.m
//  OVCRM
//
//  Created by Apple on 19/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SFPriceBookDetail.h"

@implementation SFPriceBookDetail


-(NSString *) sfName{ return @"Product__c"; }
-(NSString *) sqlName{ return @"ProductPriceList"; }

-(NSDictionary *) schema{
	return [NSDictionary dictionaryWithObjectsAndKeys:
			@"CreatedBy", @"LOOKUP",
			@"LastModifiedBy", @"LOOKUP",
			@"CreatedDate", @"DATETIME",
			@"LastModifiedDate", @"DATETIME",
			@"Name", @"TEXT",
			
			@"X1st_Inv__c", @"NUMBER",
			@"X1st_Order__c", @"NUMBER",
			@"X2nd_Inv__c", @"NUMBER",
			@"X2nd_Order__c", @"NUMBER",
			@"X3th_Inv__c", @"NUMBER",
			@"X3th_Order__c", @"NUMBER",
			@"X4_Inv__c", @"NUMBER",
			@"X4_Order__c", @"NUMBER",
			@"Active__c", @"TEXT",
			@"Brand__c", @"PICKLIST",
			@"Class__c", @"PICKLIST",
			@"Description__c", @"TEXT",
			@"Discount_Order__c", @"TEXT",
			@"In_Stock__c", @"NUMBER",
			@"IsDelMassCreate__c", @"TEXT",
			@"Is_Main__c", @"TEXT",
			@"List_Price__c", @"TEXT",
			@"List_Price_Text__c", @"NUMBER",
			@"Number_Range__c", @"NUMBER",
			@"On_Shelf__c", @"NUMBER",
			@"On_Shelf_Price__c", @"NUMBER",
			@"Order__c", @"NUMBER",
			@"Packaging__c", @"PICKLIST",
			@"Pack_Size__c", @"NUMBER",
			@"Price_Book__c", @"TEXT",
			@"Product_Category__c", @"PICKLIST",
			@"Product_Category_F__c", @"TEXT",
			@"Product_Code__c", @"TEXT",
			@"Product_Family__c", @"PICKLIST",
			@"Products_Database__c", @"TEXT",
			@"Report_3__c", @"NUMBER",
			@"Reason_for_Return__c", @"PICKLIST",
			@"Return_Quantity__c", @"NUMBER",
			@"Sales_Price__c", @"NUMBER",
			@"Shelf_Share__c", @"NUMBER",
			@"Short_Name__c", @"TEXT",
			@"SO__c", @"NUMBER",
			@"SO_1st__c", @"NUMBER",
			@"SO_2nd__c", @"NUMBER",
			@"SO_3th__c", @"NUMBER",
			@"SO_4__c", @"NUMBER",
			@"Status__c", @"PICKLIST",
			@"Status_Promo__c", @"TEXT",
			@"Weight__c", @"NUMBER",

			nil];
}

-(NSDictionary *) mapping{
	return [NSDictionary dictionaryWithObjectsAndKeys:
			@"Brand", @"Brand__c",
			@"ProductPrice_PK", @"Price_Book__c",
			@"ProductCode", @"Product_Code__c",
			@"ProductFamily", @"Product_Family__c",
			@"SalesPrice", @"Sales_Price__c",
			@"ProductName", @"Name", 
			nil];
}



@end
