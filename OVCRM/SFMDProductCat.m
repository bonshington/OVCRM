//
//  SFMDProductCat.m
//  OVCRM
//
//  Created by Apple on 20/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SFMDProductCat.h"

@implementation SFMDProductCat

-(NSString *) sfName{
	return @"MD_Product_Category__c";
}

-(NSString *) sqlName{

	return @"MD_Product_Category__c";
}

-(NSDictionary *) schema{
	return [NSDictionary dictionaryWithObjectsAndKeys:
			@"TEXT", @"Code__c", 
			@"NUMEBR", @"Runing_Number__c", 
			nil];
}

-(NSDictionary *)mapping{
	return [NSDictionary new];
}

-(void) sync:(id<OVSyncProtocal>)_controller{
	
	[super sync:_controller where:nil];
}

@end
