//
//  OVCallCardController.m
//  OVCRM
//
//  Created by Apple on 20/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OVCallCardController.h"
#import "SFCallCard.h"
#import "SFProduct.h"
#import "OVDatabase.h"

@implementation OVCallCardController

@synthesize searchBar, tableView, product, callcard, data, filtered, historyColumn, historyTable;


- (void)viewDidLoad
{
	self.delegate = self;
	
    [super viewDidLoad];
	
	self.title = @"Call Card";
    
	
	OVDatabase *db = [OVDatabase sharedInstance];
	
	if(!db.open)[db open];
	
	
	[self loadCallCard];
	
	[self loadData];
	
	
	historyManager = [[OVHistoryManager alloc] initWithTableView:self.historyTable 
														  column:self.historyColumn 
													   container:self.tableView];
	
	swipeLeft  = [[UISwipeGestureRecognizer alloc] initWithTarget:historyManager action:@selector(show:)];
	swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:historyManager action:@selector(hide:)];
	swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
	swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
	
}

-(void) viewDidAppear:(BOOL)animated{
	[self.tableView addGestureRecognizer:swipeLeft];
	[self.historyTable addGestureRecognizer:swipeRight];
}

-(void) viewDidDisappear:(BOOL)animated{
	[self.tableView removeGestureRecognizer:swipeLeft];
	[self.historyTable removeGestureRecognizer:swipeRight];
}

-(void) loadCallCard{

	OVDatabase *db = [OVDatabase sharedInstance];
	
	NSArray *unsync = [[db executeQuery:@"select * from Upload where planId = ? and sObject = 'Call_Card__c' and syncTime is null limit 1", self.planId] readToEnd];
	
	// resuming
	if(unsync != nil && unsync.count > 0){
		
		self.callcard = [NSMutableDictionary dictionaryWithDictionary:[SFJsonUtils objectFromJSONString:[unsync objectAtIndex:0 forKey:@"json"]]];
		
		[db executeUpdate:@"delete from Upload where planId = ? and sObject = 'Call_Card__c' and syncTime is null", self.planId];
	}
	else{
		// laod existing sync
		NSArray *existing = [[db executeQuery:[NSString stringWithFormat:
												@"select c.* \
												from	Call_Card__c c \
												join	Plan p \
													on	p.Account_ID = c.Account__c \
													and date(p.Date_Plan) = date(c.Checking_Date__c) \
												where	p.Id = '%@' limit 1", self.planId]] readToEnd];
		
		if(existing != nil && existing.count > 0){
			self.callcard = [NSMutableDictionary dictionaryWithDictionary:[existing objectAtIndex:0]];
		}
		else{
			// new data
			self.callcard = [NSMutableDictionary new];
			
			NSString *guid = [NSString guid];
			
			[self.callcard setObject:self.accountId forKey:@"Account__c"];
			[self.callcard setObject:@"IPAD" forKey:@"Source_System__c"];
			[self.callcard setObject:[[NSDate date] format:@"yyyy-MM-dd"] forKey:@"Checking_Date__c"];
			[self.callcard setObject:guid forKey:@"Name"];
			[self.callcard setObject:guid forKey:@"Id"];
		}
	}
	
}

-(void) loadData{
	
	OVDatabase *db = [OVDatabase sharedInstance];
	
	NSMutableDictionary *merge = [NSMutableDictionary new];
	
	
	NSDictionary *existing = [[db executeQuery:@"Select * From Stock__c where Call_Card__c = ?", [self.callcard objectForKey:@"Id"]] readToEndBy:@"prod_db_id__c"];
	
	if(existing != nil){
		[existing enumerateKeysAndObjectsUsingBlock:^(NSString *prodId, NSDictionary *row, BOOL *stop){
			[merge setObject:row forKey:prodId];
		}];
	}
	
	
	NSArray *resume = [[db executeQuery:@"select * from Upload where planId = ? and sObject = 'Stock__c' and syncTime is null", self.planId] readToEnd];

	if(resume != nil && resume.count > 0){
		
		[resume enumerateObjectsUsingBlock:^(NSDictionary *upload, NSUInteger index, BOOL *stop){
			
			NSDictionary *json = [upload objectForKey:@"json"];
			
			[merge setObject:json forKey:[json objectForKey:@"prod_db_id__c"]];
		}];
		
		[db executeUpdate:@"delete from Upload where planId = ? and sObject = 'Stock__c' and syncTime is null", self.planId];
	}
	
	
	self.data = merge;
}




@end
