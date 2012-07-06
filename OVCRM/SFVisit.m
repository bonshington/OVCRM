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

-(NSDictionary *)schema{
    return [NSDictionary dictionaryWithObjectsAndKeys:
            //@"Id", @"TEXT",
            @"ActivityDateTime", @"TEXT",
            @"toLabel(Type)", @"TEXT",
            @"IsVisibleInSelfService", @"TEXT",
            @"Account_Name__c", @"TEXT",
            @"Call_Card__c", @"TEXT",
            @"Collection__c", @"TEXT",
            @"Competitive_Activities__c", @"TEXT",
            @"Delivery__c", @"TEXT",
            @"Frequency__c", @"TEXT",
            @"Goods_Return__c", @"TEXT",
            @"Latitude__c", @"NUMBER",
            @"Longtitude__c", @"NUMBER",
            @"Merchaindising__c", @"TEXT",
            @"Order_Taking__c", @"TEXT",
            @"PC_Brief__c", @"TEXT",
            @"Sales_Talk__c", @"TEXT",
            @"Source_System__c", @"TEXT",
            @"Time_in__c", @"TEXT",
            @"Time_Out__c", @"TEXT",
            @"Trade_Program_Execution__c", @"TEXT",
            @"User_ID__c", @"TEXT",
            @"UserVisit__c", @"TEXT",
            @"Visit__c", @"TEXT",
            @"toLabel(Visit_Type__c)", @"TEXT",
            nil];

}

+(void) loadAfterDate:(NSString *)date{
    
    [super loadWithQuery:[NSString stringWithFormat:@"select %@ from Event where ActivityDate >= %@", SFVisit_columns, date] delegate:[SFVisit new]];
}

@end
