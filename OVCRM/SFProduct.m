//
//  SFProduct.m
//  OVCRM
//
//  Created by Apple on 09/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SFProduct.h"



@implementation SFProduct

#pragma mark - SFObjectProtocal

-(NSString *) SFName{
    return @"Product__c";
}

- (NSDictionary *)schema{
    return [NSDictionary dictionaryWithObjectsAndKeys:
            @"LOOKUP", @"CreatedBy",
            @"DATETIME", @"CreatedDate", 
            @"LOOKUP", @"LastModifiedBy",
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
            @"NUMBER", @"In_Stock__c",
            @"TEXT", @"IsDelMassCreate__c",
            @"TEXT", @"List_Price__c",
            @"NUMBER", @"On_Shelf__c",
            @"NUMBER", @"On_Shelf_Price__c",
            @"NUMBER", @"Order__c",
            @"PICKLIST", @"Packaging__c",
            @"NUMBER", @"Pack_Size__c",
            @"PICKLIST", @"Product_Category__c",
            @"TEXT", @"Product_Code__c",
            @"PICKLIST", @"Product_Family__c",
            @"PICKLIST", @"Reason_for_Return__c",
            @"NUMBER", @"Return_Quantity__c",
            @"TEXT", @"Sales_Price__c",
            @"NUMBER", @"Shelf_Share__c",
            @"TEXT", @"Short_Name__c",
            @"NUMBER", @"SO__c",
            @"NUMBER", @"SO_1st__c",
            @"NUMBER", @"SO_2nd__c",
            @"NUMBER", @"SO_3th__c",
            @"NUMBER", @"SO_4__c",
            @"PICKLIST", @"Status__c",
            @"NUMBER", @"Weight__c",
            nil];
}



-(void)sync:(id<OVSyncProtocal>)controller{
    
    self.controller = controller;
    
    NSString *lastSyncDate = @"2000-01-01";
    
    [super.controller updateStatus:@"Requesting data"];
    
    [sObject loadWithQuery:[NSString stringWithFormat:
							@"select Id,%@ from Product__c where CreatedDate >= %@T00:00:00z LastModifiedDate >= %@T00:00:00z"
							, [[self toSFColumns] componentsJoinedByString:@","]
                            , lastSyncDate
                            , lastSyncDate] 
				  delegate:self];
}

@end
