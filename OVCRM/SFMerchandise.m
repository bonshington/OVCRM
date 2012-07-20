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

-(NSString *)sfName{ return @"Merchandise__c";}
-(NSString *)sqlName{ return @"Merchandise";}

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
			@"Account_ID", @"Account__c",
			@"MCD_Share", @"Shelf_Share__c",
			@"MCD_Price", @"On_Shelf_Price__c",
			@"Product_Id", @"Products__c",
			nil];
}

-(void)sync:(id<OVSyncProtocal>)_controller{

	[super syncRecent:_controller];
	
}

@end
