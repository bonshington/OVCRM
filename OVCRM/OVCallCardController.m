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

@synthesize searchBar, tableView, product, callcard, data, filtered, history;


- (void)viewDidLoad
{
	self.delegate = self;
	
    [super viewDidLoad];
    
	
	OVDatabase *db = [OVDatabase sharedInstance];
	
	if(!db.open)[db open];
	
	
	[self loadCallCard];
	
	[self loadData];
	
	[self loadHistory];
	
	self.title = @"Call Card";
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

-(void) loadHistory{
	self.history = [[[OVDatabase sharedInstance] executeQuery:
					 @"select 	st.prod_db_id__c \
					 , max(case when c0.Id = st.Stock__c then c0.Checking_Date__c else nil end) as date0 \
					 , max(case when c1.Id = st.Stock__c then c1.Checking_Date__c else nil end) as date1 \
					 , max(case when c2.Id = st.Stock__c then c2.Checking_Date__c else nil end) as date2 \
					 , max(case when c3.Id = st.Stock__c then c3.Checking_Date__c else nil end) as date3 \
					 \
					 , max(case when c0.Id = st.Stock__c then st.In_Stock__c else nil end) as inv0 \
					 , max(case when c1.Id = st.Stock__c then st.In_Stock__c else nil end) as inv1 \
					 , max(case when c2.Id = st.Stock__c then st.In_Stock__c else nil end) as inv2 \
					 , max(case when c3.Id = st.Stock__c then st.In_Stock__c else nil end) as inv3 \
					 \
					 from 	CallCard_Stock st \
					 left join (select Id, CS_Date from Call_Card__c where Id not like '-%' and Checking_Date__c <> date('now') order by Checking_Date__c desc limit 1, 0) c0 on c0.Id = st.Stock__c \
					 left join (select Id, CS_Date from Call_Card__c where Id not like '-%' and Checking_Date__c <> date('now') order by Checking_Date__c desc limit 1, 1) c1 on c1.Id = st.Stock__c \
					 left join (select Id, CS_Date from Call_Card__c where Id not like '-%' and Checking_Date__c <> date('now') order by Checking_Date__c desc limit 1, 2) c2 on c2.Id = st.Stock__c \
					 left join (select Id, CS_Date from Call_Card__c where Id not like '-%' and Checking_Date__c <> date('now') order by Checking_Date__c desc limit 1, 3) c3 on c3.Id = st.Stock__c \
					 group by st.prod_db_id__c"] 
					readToEndBy:@"prod_db_id__c"];
}



@end
