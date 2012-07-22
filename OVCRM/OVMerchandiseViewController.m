//
//  OVMerchandiseViewController.m
//  OVCRM
//
//  Created by Sopon Srisummasheep on 7/21/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import "OVMerchandiseViewController.h"

@implementation OVMerchandiseViewController

@synthesize data;


- (void)viewDidLoad
{
	self.delegate = self;
	
	[self load];
	
    [super viewDidLoad];
    
	self.title = @"Market Intelligence";
}

-(NSArray *)loadProducts{
	return [SFProduct availableProduct];
}

-(void) load{
	
	OVDatabase *db = [OVDatabase sharedInstance];
	
	if(!db.open)
		[db open];
	
	self.data = [NSMutableDictionary dictionaryWithDictionary:[[db executeQuery:@"select * from Merchandise__c where Account__c = ? and Date__c in (select ActivityDate from Plan where Id = ?)", self.accountId, self.planId] readToEndBy:@"prod_db_id__c"]];
	
	
}


@end
