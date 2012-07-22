//
//  OVGoodReturnViewController.m
//  OVCRM
//
//  Created by Sopon Srisummasheep on 7/22/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import "OVGoodReturnViewController.h"


@implementation OVGoodReturnViewController

@synthesize data;

- (void)viewDidLoad
{
	self.delegate = self;
	
	[self load];
	
    [super viewDidLoad];
    
	self.title = @"Market Hygiene";
}

-(NSArray *)loadProducts{
	return [SFProduct availableProduct];
}

-(void) load{
	
	OVDatabase *db = [OVDatabase sharedInstance];
	
	if(!db.open)
		[db open];
	
	self.data = [NSMutableDictionary dictionaryWithDictionary:
				 [[db executeQuery:
				   @"select * from Goods_Return__c where Account__c = ? and Return_Date__c in (select ActivityDate from Plan where Id = ?)", self.accountId, self.planId] readToEndBy:@"prod_db_id__c"]];
	
	
}

@end
