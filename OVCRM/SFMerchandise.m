//
//  SFMerchandise.m
//  OVCRM
//
//  Created by Apple on 14/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SFMerchandise.h"
#import "AppDelegate.h"

@implementation SFMerchandise

-(NSString *)SFName{ return @"Merchandise__c";}

-(NSDictionary *)schema{
    return [NSDictionary dictionaryWithObjectsAndKeys:
            @"LOOKUP", @"CreatedBy",
			@"LOOKUP", @"LastModifiedBy",
			@"TEXT", @"Name",
			@"LOOKUP", @"Owner",
			@"NUMBER", @"ABF_Price__c",
			@"TEXT", @"Account__c",
			@"TEXT", @"Date__c",
			@"NUMBER", @"Shelf_Share__c",
			@"TEXT", @"Item_Code__c",
			@"NUMBER", @"On_Shelf_Price__c",
			@"TEXT", @"Pack_Size__c",
			@"TEXT", @"Products__c",
			@"TEXT", @"Source_System__c",
			nil];
	
}

-(NSDictionary *)mapping{
	return [NSDictionary dictionaryWithObjectsAndKeys:
			@"Merchandise", @"Merchandise__c",
			@"PK", @"Id",
			@"Account_ID", @"Account__c",
			@"MCD_Share", @"Shelf_Share__c",
			@"MCD_Price", @"On_Shelf_Price__c",
			@"Product_Id", @"Products__c",
			nil];
}

-(void)sync:(id<OVSyncProtocal>)controller{

	//[[OVDatabase sharedInstance] executeUpdate:@"drop table Merchandise"];
	
	self.controller = controller;
	
	NSString *lastSyncDate = [[AppDelegate sharedInstance].user objectForKey:@"lastSyncDate"];
    
    [super.controller updateStatus:@"Requesting data"];
    
    [sObject loadWithQuery:[NSString stringWithFormat:
							@"select Id,%@ from Merchandise__c where CreatedDate >= %@T00:00:00z and LastModifiedDate >= %@T00:00:00z "
							, [[self toSFColumns] componentsJoinedByString:@","]
							, lastSyncDate
							, lastSyncDate] 
				  delegate:self];
}

@end
