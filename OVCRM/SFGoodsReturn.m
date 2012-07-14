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

-(NSString *)SFName{ return @"Goods_Return__c";}

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
			@"ReturnDetail", @"Goods_Return__c",
			@"Product_ID", @"Products__c",
			@"Reason", @"Reason_for_Return__c",
			@"Quantity", @"Return_Quantity__c",
			nil];
}

-(void)sync:(id<OVSyncProtocal>)controller{
    
    self.controller = controller;
    
    NSString *lastSyncDate = [[AppDelegate sharedInstance].user objectForKey:@"lastSyncDate"];
    
    [super.controller updateStatus:@"Requesting data"];
    
    [sObject loadWithQuery:[NSString stringWithFormat:
							@"select Id,%@ from Goods_Return__c where CreatedDate >= %@T00:00:00z and LastModifiedDate >= %@T00:00:00z"
							, [[self toSFColumns] componentsJoinedByString:@","]
                            , lastSyncDate
                            , lastSyncDate] 
				  delegate:self];
}

@end
