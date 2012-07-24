//
//  SFPromotion.m
//  OVCRM
//
//  Created by Apple on 23/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SFPromotion.h"

@implementation SFPromotion

-(NSString *)sfName{
	return @"Promotion__c";
}

-(NSString *)sqlName{
	return @"Promotion__c";
}

-(NSDictionary *)schema{
	return [NSDictionary dictionaryWithObjectsAndKeys:
			
			@"TEXT", @"Start_Date__c",
			@"TEXT", @"End_Date__c",
			
			@"PICKLIST", @"Quantity_Type__c",
			@"TEXT", @"Salesman__c",
			@"TEXT", @"Shop_Type__c", // fk to where?
			
			@"NUMEBR", @"Value__c",
			@"NUMBER", @"Volume__c", 
			nil];
}

-(NSDictionary *)mapping{
	return [NSDictionary new];
}

-(void) sync:(id<OVSyncProtocal>)_controller{
	return [super syncRecent:_controller];
}

@end
