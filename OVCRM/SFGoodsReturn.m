//
//  SFGoodsReturn.m
//  OVCRM
//
//  Created by Apple on 14/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SFGoodsReturn.h"
#import "AppDelegate.h"

@implementation SFGoodsReturn

-(NSString *)sfName{ return @"Goods_Return__c";}
-(NSString *)sqlName{ return @"ReturnDetail";}

-(NSDictionary *)schema{
    return [NSDictionary dictionaryWithObjectsAndKeys:
            @"LOOKUP", @"CreatedBy",
            @"DATETIME", @"CreatedDate", 
            @"LOOKUP", @"LastModifiedBy",
            @"DATETIME", @"LastModifiedDate",
			@"TEXT", @"Name",
			
			@"TEXT", @"Account__c",
			@"TEXT", @"Account_Receivable_Detail__c",
			@"TEXT", @"Customer_Name__c",
			@"TEXT", @"Invoice_Number__c",
			@"TEXT", @"Products__c",
			@"PICKLIST", @"Reason_for_Return__c",
			@"TEXT", @"Return_Date__c",
			@"NUMBER", @"Return_Quantity__c",
			@"NUMBER", @"Sales_Volume__c",
			@"TEXT", @"Shop_Type__c",
			@"TEXT", @"Source_System__c",
			nil];
	
}

-(NSDictionary *)mapping{
	return [NSDictionary dictionaryWithObjectsAndKeys:
			@"Product_ID", @"Products__c",
			@"Reason", @"Reason_for_Return__c",
			@"Quantity", @"Return_Quantity__c",
			nil];
}

-(void)sync:(id<OVSyncProtocal>)_controller{
    
	[super syncRecent:_controller];
}

@end
