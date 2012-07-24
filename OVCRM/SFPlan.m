//
//  SFVisit.m
//  OVCRM
//
//  Created by Apple on 05/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SFPlan.h"
#import "AppDelegate.h"

@implementation SFPlan

-(NSString *)sfName{ return @"Event";}
-(NSString *)sqlName{ return @"Plan";}


-(NSDictionary *)schema{
    return [NSDictionary dictionaryWithObjectsAndKeys:
            //@"Id", @"TEXT",
            @"TEXT", @"IsAllDayEvent",
            @"LOOKUP.Name", @"Owner",
            @"LOOKUP", @"CreatedBy",
            @"DATETIME", @"CreatedDate", 
            @"DATETIME", @"ActivityDate",
            @"TEXT", @"Description",
            @"NUMBER", @"DurationInMinutes",
            //@"TEXT", @"Email",
            @"TEXT", @"EndDateTime",
            //@"LOOKUP", @"LastModifiedBy",
            //@"DATETIME", @"LastModifiedDate",
            @"TEXT", @"Location",
            @"LOOKUP", @"Who",
            //@"TEXT", @"Phone",
            @"TEXT", @"IsPrivate",
            @"LOOKUP", @"What",
            @"TEXT", @"WhatId",
            @"TEXT", @"ShowAs",
            @"DATETIME", @"StartDateTime",
            @"TEXT", @"Subject",
            @"DATETIME", @"ActivityDateTime",
            @"PICKUP", @"Type",
            //@"TEXT", @"IsVisibleInSelfService",
            @"TEXT", @"Account_Name__c",
            @"TEXT", @"Call_Card__c",
            @"TEXT", @"Collection__c",
            @"TEXT", @"Competitive_Activities__c",
            @"TEXT", @"Delivery__c",
            @"TEXT", @"Frequency__c",
            @"TEXT", @"Goods_Return__c",
            @"NUMBER", @"Latitude__c",
            @"NUMBER", @"Longtitude__c",
            @"TEXT", @"Merchaindising__c",
            @"TEXT", @"Order_Taking__c",
            @"TEXT", @"PC_Brief__c",
            @"TEXT", @"Sales_Talk__c",
            @"TEXT", @"Source_System__c",
            @"TEXT", @"Time_in__c",
            @"TEXT", @"Time_Out__c",
            @"TEXT", @"Trade_Program_Execution__c",
            @"TEXT", @"User_ID__c",
            @"TEXT", @"UserVisit__c",
            @"TEXT", @"Visit__c",
            @"PICKLIST", @"Visit_Type__c",
            nil];

}

-(NSDictionary *) mapping{
	
	//@"Plan_ID ,Account_ID ,Account_Name ,Date_Plan ,TimePlan_In ,TimePlan_Out ,Visit_Date ,Visit_TimeIn ,Visit_TimeOut ,Latitude ,Longtitude , LastSyncDate , LastSyncTime";
	
	return [NSDictionary dictionaryWithObjectsAndKeys:
			
			@"Account_ID", @"WhatId",
			@"Account_Name", @"What",
			@"Date_Plan", @"ActivityDateTime",
			@"TimePlan_In", @"StartDateTime",
			@"TimePlan_Out", @"EndDateTime",
			@"Visit_Date", @"StartDateTime",
			@"Visit_TimeIn", @"Time_in__c",
			@"Visit_TimeOut", @"Time_Out__c",
			@"Latitude", @"Latitude__c",
			@"Longtitude", @"Longtitude__c",
			//@"LastSyncDate", @"",
			//@"LastSyncTime", @"",
			nil];
}

-(void)sync:(id<OVSyncProtocal>)_controller{
    
	[super sync:_controller where:[NSString stringWithFormat:@"User_ID__c like '%@%%'", [[AppDelegate sharedInstance].user objectForKey:@"userId"]]];
}

+(NSArray *) selectToday{
    
    OVDatabase *db = [OVDatabase sharedInstance];
    
    if(!db.open)[db open];
	
    NSString *sql = @"select *, substr(TIME(substr(TimePlan_In, 1, 23), 'localtime'), 1, 5) as time from Plan where 1=1 or date(TimePlan_In) = CURRENT_DATE order by DATETIME(TimePlan_In)";
    
	return [[db executeQuery:sql] readToEnd];
}

@end
