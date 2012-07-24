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


-(void) load{
	
	OVDatabase *db = [OVDatabase sharedInstance];
	
	if(!db.open)
		[db open];
	
	
	NSMutableDictionary *merge = [NSMutableDictionary new];
	
	
	NSArray *existing = [[db executeQuery:@"select * from Merchandise__c where Account__c = ? and Date__c in (select ActivityDate from Plan where Id = ?)", self.accountId, self.planId] readToEnd];
	
	if(existing != nil && existing.count > 0){
		[existing enumerateObjectsUsingBlock:^(NSDictionary *row, NSUInteger index, BOOL *stop){
			[merge setObject:row forKey:[row objectForKey:@"prod_db_id__c"]];
		}];
	}
	
	
	//check unsync for resuming
	NSArray *unsync = [[db executeQuery:@"select * from Upload where planId = ? and syncTime is null and sObject = 'Merchandise__c'", self.planId] readToEnd];
	
	if(unsync != nil && unsync.count > 0){
		
		[unsync enumerateObjectsUsingBlock:^(NSDictionary *upload, NSUInteger index, BOOL *stop){
			
			NSDictionary *json =  [SFJsonUtils objectFromJSONString:[upload objectForKey:@"json"]];
			
			[merge setObject:json forKey:[json objectForKey:@"prod_db_id__c"]];
		}];
		
		[db executeUpdate:@"delete from Upload where planId = ? and sObject = 'Merchandise__c' and syncTime is null", self.planId];
	}
	
	self.data = merge;
}


@end
