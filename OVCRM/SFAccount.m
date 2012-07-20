//
//  SFAccount.m
//  OVCRM
//
//  Created by Sopon Srisummasheep on 7/4/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import "SFAccount.h"
#import "AppDelegate.h"

@implementation SFAccount

#pragma mark - SFObjectProtocal

-(NSString *) sfName{ return @"Account"; }
-(NSString *) sqlName{ return @"Account"; }

- (NSDictionary *)schema{
    return [NSDictionary dictionaryWithObjectsAndKeys:
            @"TEXT", @"Name",
            @"TEXT", @"AccountNumber",
            @"TEXT", @"OwnerId",
            @"TEXT", @"Site",
            @"TEXT", @"AnnualRevenue",
            @"LOOKUP", @"CreatedBy",
            @"DATETIME", @"CreatedDate", 
            @"TEXT", @"Description",
            @"NUMBER", @"NumberOfEmployees",
            @"TEXT", @"Fax",
            @"TEXT", @"Industry",
            @"LOOKUP", @"LastModifiedBy",
            @"DATETIME", @"LastModifiedDate",
            @"PICKLIST", @"Ownership",
            @"LOOKUP", @"Parent",
            @"TEXT", @"Phone",
            @"TEXT", @"Rating",
            @"PICKLIST", @"Type",
            @"TEXT", @"Website",
            @"TEXT", @"Account_Source__c",
            @"TEXT", @"Account_Number_EXT__c",
            @"TEXT", @"Account_Type__c",
            @"TEXT", @"Active__c",
            @"TEXT", @"Addr1__c",
            @"TEXT", @"Addr2__c",
            @"TEXT", @"Addr3__c",
            @"TEXT", @"Amphur__c",
            @"NUMBER", @"Average_Item__c",
            @"NUMBER", @"AvgSale__c",
            @"TEXT", @"Balance__c",
            @"TEXT", @"City__c",
            @"TEXT", @"Contact_1__c",
            @"TEXT", @"Contact_2__c",
            @"TEXT", @"Contact_Name_1__c",
            @"TEXT", @"Contact_Name_2__c",
            @"TEXT", @"Contact_Name_3__c",
            @"TEXT", @"Contact_Name_4__c",
            @"TEXT", @"Contact_Name_5__c",
            @"TEXT", @"Contact_Name_6__c",
            @"TEXT", @"Contact_Position_1__c",
            @"TEXT", @"Contact_Position_2__c",
            @"TEXT", @"Contact_Position_3__c",
            @"TEXT", @"Contact_Position_4__c",
            @"TEXT", @"Contact_Position_5__c",
            @"TEXT", @"Contact_Position_6__c",
            @"TEXT", @"Contact_Tel_1__c",
            @"TEXT", @"Contact_Tel_2__c",
            @"TEXT", @"Contact_Tel_3__c",
            @"TEXT", @"Contact_Tel_4__c",
            @"TEXT", @"Contact_Tel_5__c",
            @"TEXT", @"Contact_Tel_6__c",
            @"TEXT", @"Value_2__c",
            @"TEXT", @"Value_1__c",
            @"TEXT", @"Customer_Priority__c",
            @"TEXT", @"DiscSeq__c",
            @"NUMBER", @"First_Latitude__c",
            @"NUMBER", @"First_Longitude__c",
            @"TEXT", @"Friday__c",
            @"NUMBER", @"GroupProm1__c",
            @"NUMBER", @"GroupProm2__c",
            @"NUMBER", @"GroupProm3__c",
            @"TEXT", @"INT_ActionType__c",
            @"NUMBER", @"ItemProm1__c",
            @"NUMBER", @"ItemProm2__c",
            @"NUMBER", @"ItemProm3__c",
            @"TEXT", @"KWS_Customer__c",
            @"TEXT", @"Last_modified_time__c",
            @"NUMBER", @"Last_Latitude__c",
            @"NUMBER", @"Last_Longitude__c",
            @"NUMBER", @"Limit__c",
            @"TEXT", @"MD_Amphur_Code__c",
            @"TEXT", @"MD_City_Code__c",
            @"TEXT", @"MD_Province_Code__c",
            @"TEXT", @"MD_Shop_Type_Code__c",
            @"TEXT", @"MD_Status_Code__c",
            @"TEXT", @"MD_Customer_Business__c",
            @"TEXT", @"MD_Customer_Group__c",
            @"TEXT", @"Monday__c",
            @"TEXT", @"No_Refund__c",
            @"TEXT", @"Note_1__c",
            @"TEXT", @"Note_2__c",
            @"NUMBER", @"Number_of_Locations__c",
            @"NUMBER", @"OftenNum__c",
            @"TEXT", @"OftenPattern__c",
            @"TEXT", @"OneTime__c",
            @"NUMBER", @"Order_Taking_Amount__c",
            @"TEXT", @"Parent_Account_Number__c",
            @"TEXT", @"Pay_Type__c",
            @"TEXT", @"Phone__c",
            @"TEXT", @"PriceListNo__c",
            @"TEXT", @"Province__c",
            @"TEXT", @"Province_Code__c",
            @"TEXT", @"Route_No__c",
            @"TEXT", @"Salesman__c",
            @"TEXT", @"Saturday__c",
            @"TEXT", @"Shop_Type__c",
            @"TEXT", @"Short_Name__c",
            @"TEXT", @"SLA__c",
            @"TEXT", @"SLA_Expiration_Date__c",
            @"TEXT", @"SLA_Serial_Number__c",
            @"TEXT", @"Source_System__c",
            @"TEXT", @"Status__c",
            @"TEXT", @"Sunday__c",
            @"NUMBER", @"Term__c",
            @"TEXT", @"Thursday__c",
            @"TEXT", @"Tuesday__c",
            @"TEXT", @"Upsell_Opportunity__c",
            @"TEXT", @"Value_10__c",
            @"TEXT", @"Value_3__c",
            @"TEXT", @"Value_4__c",
            @"TEXT", @"Value_5__c",
            @"TEXT", @"Value_6__c",
            @"TEXT", @"Value_7__c",
            @"TEXT", @"Value_8__c",
            @"TEXT", @"Value_9__c",
            @"NUMBER", @"VisitDayOfWeek__c",
            @"NUMBER", @"VisitDaySeq__c",
            @"TEXT", @"VisitPattern__c",
            @"TEXT", @"Wednesday__c",
            nil];
}



+ (void) loadAccountsWithRoute:(NSString *)route{
    
    SFAccount *this = [SFAccount new];
    
    [super loadWithQuery:[NSString stringWithFormat:
                          @"select Id,%@ from Account where Route_no__c = '%@'"
                          , [[this toSFColumns] componentsJoinedByString:@","]
                          , route] 
                delegate:this];
}

+(NSDictionary *) selectAccountContextOf:(NSString *)accountId{

	OVDatabase *db = [OVDatabase sharedInstance];
	
	return [NSDictionary dictionaryWithObjectsAndKeys:
			[[db executeQuery:@"select * from Account where Id = ?", accountId] readToEnd], @"Account", 
			[[db executeQuery:@"select * from Event where WhatId = ?", accountId] readToEnd], @"Event",
			[[db executeQuery:@"select * from Stock where 1=1 or AccountId__c = ? order by Stock_Update__c desc, Product_Name asc", accountId] readToEnd], @"Stock", 
			[[db executeQuery:@"select * from Merchandise where 1=1 or Account_ID = ? order by Date__c desc, Name asc", accountId] readToEnd], @"Merchandise",
			[[db executeQuery:@"select * from Collection where"] readToEnd], @"Collection",
			nil];
}

-(void)sync:(id<OVSyncProtocal>)_controller{
    
	[super sync:_controller where:nil];
	
	/*[NSString stringWithFormat:
								   @"Route_no__c = '%@'"
								   , [[AppDelegate sharedInstance].user objectForKey:@"route"]
								   ]
	 ];*/
}

@end
