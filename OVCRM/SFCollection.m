//
//  SFCollection.m
//  OVCRM
//
//  Created by Apple on 14/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SFCollection.h"
#import "AppDelegate.h"

@implementation SFCollection


-(NSString *)sfName{ return @"Collection__c";}
-(NSString *)sqlName{ return @"Collection";}

-(NSDictionary *)schema{
    return [NSDictionary dictionaryWithObjectsAndKeys:
            @"LOOKUP", @"CreatedBy",
            @"DATETIME", @"CreatedDate", 
            @"LOOKUP", @"LastModifiedBy",
            @"DATETIME", @"LastModifiedDate",
			@"TEXT", @"Name",
			
			@"TEXT", @"Account_Receivable__c",
			@"PICKLIST", @"Bank__c",
			@"TEXT", @"Branch__c",
			@"TEXT", @"Cheque_No__c",
			@"TEXT", @"Collected_Amount__c",
			@"TEXT", @"Credit_Balance__c",
			@"TEXT", @"Credit_Limit__c",
			@"TEXT", @"Customer_Code__c",
			@"TEXT", @"Customer_Name__c",
			@"NUMBER", @"Grand_Total__c",
			@"TEXT", @"Over_Credit__c",
			@"TEXT", @"Over_Credit_Amount__c",
			@"PICKLIST", @"Payment_Type__c",
			@"TEXT", @"Source_System__c",
			@"TEXT", @"Sum_Net_Total__c",
			nil];
	
}

-(NSDictionary *)mapping{
	return [NSDictionary dictionaryWithObjectsAndKeys:
			@"Invoice_No", @"Account_Receivable__c",
			@"Bank", @"Bank__c",
			@"Branch", @"Branch__c",
			@"ChequeNo", @"Cheque_No__c",
			@"Amount", @"Collected_Amount__c",
			@"PayType", @"Payment_Type__c",
			nil];
}

-(void)sync:(id<OVSyncProtocal>)_controller{
    
	NSString *lastSyncDate = [[AppDelegate sharedInstance].user objectForKey:@"lastSyncDate"];
	
	[super sync:_controller where:[NSString stringWithFormat:@"CreatedDate >= %@T00:00:00z and LastModifiedDate >= %@T00:00:00z", lastSyncDate, lastSyncDate]];
}


@end
