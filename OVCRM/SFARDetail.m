//
//  SFARDetail.m
//  OVCRM
//
//  Created by Sopon Srisummasheep on 7/22/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import "SFARDetail.h"

@implementation SFARDetail

-(NSString *) sfName{
	return @"Account_Receivable_Detail__c";
}

-(NSString *)sqlName{
	return @"Account_Receivable_Detail__c";
}

-(NSDictionary *) schema{
	return [NSDictionary dictionaryWithObjectsAndKeys:
			@"TEXT"		, @"Name", 
			@"LOOKUP"	, @"CreatedBy", 
			@"DATETIME"	, @"CreatedDate", 
			@"LOOKUP"	, @"LastModifiedBy",
			@"DATETIME"	, @"LastModifiedDate", 
			
			@"TEXT", @"Account_Receivable__c",
			@"TEXT", @"Amount__c",
			@"NUMBER", @"AvgCustDisc__c",
			@"TEXT", @"AvgDiscBaht__c",
			@"TEXT", @"AvgDiscPer__c",
			@"NUMBER", @"AvgGroupDisc__c",
			@"NUMBER", @"AvgShopTypeDisc__c",
			@"TEXT", @"Cost__c",
			@"TEXT", @"DI_Activity_Code__c",
			@"TEXT", @"DIcode1__c",
			@"TEXT", @"DIcode2__c",
			@"TEXT", @"DIcode3__c",
			@"TEXT", @"DIcode4__c",
			@"TEXT", @"DiscLevel1__c",
			@"TEXT", @"DiscLevel2__c",
			@"TEXT", @"DiscLevel3__c",
			@"TEXT", @"FOC_Activity_Code__c",
			@"TEXT", @"FOCcode1__c",
			@"TEXT", @"FOCcode2__c",
			@"TEXT", @"FOCcode3__c",
			@"TEXT", @"FOCcode4__c",
			@"NUMBER", @"FOC_Quantity_1__c",
			@"NUMBER", @"FOC_Quantity_2__c",
			@"NUMBER", @"FOC_Quantity_3__c",
			@"NUMBER", @"FOC_Quantity_4__c",
			@"NUMBER", @"FOC_Quantity_5__c",
			@"TEXT", @"FreeBy__c",
			@"TEXT", @"InvDate__c",
			@"TEXT", @"InvNumber__c",
			@"PICKLIST", @"IsFree__c",
			@"TEXT", @"ItemCode__c",
			@"TEXT", @"ItemDisc__c",
			@"TEXT", @"ItemDiscBaht__c",
			@"TEXT", @"ItemDiscPerAmt__c",
			@"TEXT", @"Last_Modified__c",
			@"TEXT", @"MD_AR_IsFree_Code__c",
			@"TEXT", @"MD_Transaction_Type_Code__c",
			@"TEXT", @"NetAmount__c",
			@"NUMBER", @"Original_Quantity__c",
			@"NUMBER", @"PackSize__c",
			@"TEXT", @"Price__c",
			@"TEXT", @"Price_Level__c",
			@"LOOKUP", @"Products__c",
			@"NUMBER", @"Quantity__c",
			@"PICKLIST", @"Reason_for_Return__c",
			@"TEXT", @"Reference_No__c",
			@"NUMBER", @"RefQuantity__c",
			@"NUMBER", @"Remain_Quantity__c",
			@"NUMBER", @"Return_Quantity__c",
			@"TEXT", @"RTypeCode__c",
			@"TEXT", @"Selected__c",
			@"NUMBER", @"Seq__c",
			@"TEXT", @"Source_System__c",
			@"TEXT", @"TranNote__c",
			@"PICKLIST", @"TransacType__c",
			@"TEXT", @"VatAmount__c",
			@"TEXT", @"WhsCode__c",
			
			nil];
}

-(NSDictionary *) mapping{
	return [NSDictionary new];
}

-(void) sync:(id<OVSyncProtocal>)_controller{
	
}

@end
