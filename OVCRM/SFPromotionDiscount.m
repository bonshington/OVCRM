//
//  SFPromotionDiscount.m
//  OVCRM
//
//  Created by Sopon Srisummasheep on 7/24/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import "SFPromotionDiscount.h"

@implementation SFPromotionDiscount

-(NSString *)sfName{
	return @"Promotion_Discount__c";
}

-(NSString *)sqlName{
	return @"Promotion_Discount__c";
}

-(NSDictionary *)schema{
	return [NSDictionary dictionaryWithObjectsAndKeys:
			@"TEXT"		, @"Active__c",
			@"PICKLIST"	, @"Currency_or__c",
			@"PICKLIST"	, @"Customer_Group__c",
			@"NUMBER"	, @"Discount_Rate__c",
			
			@"TEXT"		, @"Start_Date__c",
			@"TEXT"		, @"End_Date__c",
			
			nil];
}

-(NSDictionary *)mapping{
	return [NSDictionary new];
}

-(void) sync:(id<OVSyncProtocal>)_controller{
	return [super syncRecent:_controller];
}

@end
