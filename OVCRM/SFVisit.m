//
//  SFVisit.m
//  OVCRM
//
//  Created by Apple on 05/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SFVisit.h"

#define SFVisit_columns @"test test test 555"

@implementation SFVisit

-(NSString *)SFName{ return @"Event";}

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
            @"LOOKUP", @"LastModifiedBy",
            @"DATETIME", @"LastModifiedDate",
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

-(void)sync:(id<OVSyncProtocal>)controller{
    
    super.controller = controller;
    
    [sObject loadWithQuery:[NSString stringWithFormat:
							@"select Id,%@ from Event where StartDateTime >= TODAY"
							, [[self toSFColumns] componentsJoinedByString:@","]] 
				  delegate:self];
}

+(void) loadNewVisit{
    
    SFVisit *this = [SFVisit new];
    
    [super loadWithQuery:[NSString stringWithFormat:
                          @"select Id,%@ from Event where StartDateTime >= TODAY"
                          , [[this toSFColumns] componentsJoinedByString:@","]] 
                delegate:this];
}

+(FMResultSet *) selectToday{
    
    OVDatabase *db = [OVDatabase sharedInstance];
    
    if(!db.open)[db open];
    
    return [db executeQuery:@"select *, substr(TIME(substr(StartDateTime, 1, 23)), 1, 5) as time from Event where StartDateTime >= CURRENT_DATE order by DATETIME(StartDateTime)"];
}

@end
