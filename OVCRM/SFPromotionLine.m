//
//  SFPromotionLine.m
//  OVCRM
//
//  Created by Sopon Srisummasheep on 7/24/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import "SFPromotionLine.h"

@implementation SFPromotionLine

-(NSString *)sfName{
	return @"Promotion_Line_Item__c";
}

-(NSString *)sqlName{
	return @"Promotion_Line_Item__c";
}

-(NSDictionary *)schema{
	return [NSDictionary dictionaryWithObjectsAndKeys:
			@"TEXT", @"Brand__c",
			@"TEXT", @"Product_Category__c",
			@"TEXT", @"Product_Code__c",
			@"TEXT", @"Product_Family__c",
			@"TEXT", @"Product_Group__c",
			@"TEXT", @"Products_Database__c", // fk
			@"TEXT", @"Promotion__c", // fk
			nil];
}

-(NSDictionary *)mapping{
	return [NSDictionary new];
}

-(void) sync:(id<OVSyncProtocal>)_controller{
	return [super syncRecent:_controller];
}


+(NSDictionary *)current{
	return [[[OVDatabase sharedInstance] executeQuery:
			 @"select * from Promotion_Line_Item__c	\
			 where 	Promotion__c in (	\
				select Id from Promotion__c	\
				where start_date__c <= date('now') and date('now') <= end_date__c	\
			 )	\
			 "] readToEndBy:@"Products_Database__c"];
}


@end
