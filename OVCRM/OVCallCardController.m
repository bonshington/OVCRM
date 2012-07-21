//
//  OVCallCardController.m
//  OVCRM
//
//  Created by Apple on 20/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OVCallCardController.h"
#import "SFCallCard.h"
#import "OVDatabase.h"

@implementation OVCallCardController

@synthesize searchBar, tableView, nextButton, product, callcard, callcard_data, planId, accountId, filtered, history;


-(id)initWithPlanId:(NSString *)_planId 
		  accountId:(NSString *)_accountId{
	
	self = [super init];
    if (self) {
        
		self.planId = _planId;
		self.accountId = _accountId;
		
		self.title = @"Call Card";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	
	[searchBar setTranslucent:YES];
	
	if ([[[searchBar subviews] objectAtIndex:0] isKindOfClass:[UIImageView class]]){
		[[[searchBar subviews] objectAtIndex:0] removeFromSuperview];
	}
	
	
	OVDatabase *db = [OVDatabase sharedInstance];
	
	if(!db.open)[db open];
	
	self.product = [[db executeQuery:
					 @"select p.Id, p.product_Category, p.product_Code, p.packSize \
					 from	Product p \
					 join	MD_Product_Category__c md \
						on	md.Code__c = p.MD_Product_Category_Code__c \
					 where	p.Main_Product__c = '1' and p.isCancel <> 'Inactive' \
					 order by md.Runing_Number__c"] readToEnd];
	
	self.filtered = [NSMutableArray arrayWithArray:self.product];
	

	// load callcard
	NSArray *_callcard = [[db executeQuery:[NSString stringWithFormat:
										   @"select c.* \
										   from		CallCard c \
										   join		Plan p \
													on	p.Account_ID = c.Account_ID \
													and date(p.Date_Plan) = date(c.CS_Date) \
										   where	p.Id = '%@' limit 1", self.planId]] readToEnd];
	
	// existing synced
	if(_callcard != nil && _callcard.count > 0){
		self.callcard = [NSMutableDictionary dictionaryWithDictionary:[_callcard objectAtIndex:0]];
	}
	else {
		
		// try resume
		NSArray *resumeCallcard = [[db executeQuery:@"select * from Upload where planId = ? and sObject = 'Call_Card__c' limit 1", self.planId] readToEnd];
		
		if(resumeCallcard != nil && resumeCallcard.count > 0){
			
			NSMutableDictionary *loadingCallcard = [NSMutableDictionary dictionaryWithDictionary:[SFJsonUtils objectFromJSONString:[resumeCallcard objectAtIndex:0 forKey:@"json"]]];
			
			[loadingCallcard setObject:[resumeCallcard objectAtIndex:0 forKey:@"Id"] forKey:@"id"];
			
			self.callcard = loadingCallcard;
			
			[db executeUpdate:@"delete from Upload where pk = ?", [resumeCallcard valueForKey:@"pk"]];
		}
		else{
			
			// create new
			self.callcard = [NSMutableDictionary new];
			
			NSString *guid = [NSString guid];
			
			[self.callcard setObject:self.accountId forKey:@"Account_ID"];
			[self.callcard setObject:@"IPAD" forKey:@"Source_System__c"];
			[self.callcard setObject:[[NSDate date] format:@"yyyy-MM-dd"] forKey:@"CS_Date"];
			[self.callcard setObject:guid forKey:@"Name"];
			[self.callcard setObject:guid forKey:@"Id"];
		}
	}
	
	
	// load callcard data
	self.callcard_data = [NSMutableDictionary dictionaryWithDictionary:[[db executeQuery:@"Select * From CallCard_Stock where CallCard_PK = ?", [self.callcard objectForKey:@"Id"]] readToEndBy:@"prod_db_id__c"]];
	
	if(self.callcard_data == nil || self.callcard_data.count == 0){
		
		// try resume
		NSArray *resumeCallcardData = [[db executeQuery:@"select * from Upload where planId = ? and sObject = 'Stock__c'", self.planId] readToEnd];
		
		if(resumeCallcardData != nil && resumeCallcardData.count > 0){
			
			[resumeCallcardData enumerateObjectsUsingBlock:^(NSDictionary *row, NSUInteger index, BOOL *stop){
				
				NSMutableDictionary *json = [NSMutableDictionary dictionaryWithDictionary:[SFJsonUtils objectFromJSONString:[row objectForKey:@"json"]]];
				
				[json setObject:[row objectForKey:@"Id"] forKey:@"Id"];
				
				[self.callcard_data setObject:json forKey:[json objectForKey:@"prod_db_id__c"]];
			}];
			
			[db executeUpdate:@"delete from Upload where planId = ? and sObject = 'Stock__c'"];
		}
	}
	
	
	self.history = [[db executeQuery:
					 @"select 	st.Products__c \
					 , max(case when c0.Id = st.CallCard_PK then c0.CS_Date else nil end) as date0 \
					 , max(case when c1.Id = st.CallCard_PK then c1.CS_Date else nil end) as date1 \
					 , max(case when c2.Id = st.CallCard_PK then c2.CS_Date else nil end) as date2 \
					 , max(case when c3.Id = st.CallCard_PK then c3.CS_Date else nil end) as date3 \
					 \
					 , max(case when c0.Id = st.CallCard_PK then st.InStock else nil end) as inv0 \
					 , max(case when c1.Id = st.CallCard_PK then st.InStock else nil end) as inv1 \
					 , max(case when c2.Id = st.CallCard_PK then st.InStock else nil end) as inv2 \
					 , max(case when c3.Id = st.CallCard_PK then st.InStock else nil end) as inv3 \
					 \
					 from 	CallCard_Stock st \
					 left join (select Id, CS_Date from CallCard where Id not like '-%' and CS_Date <> date('now') order by CS_Date desc limit 1, 0) c0 on c0.Id = st.CallCard_PK \
					 left join (select Id, CS_Date from CallCard where Id not like '-%' and CS_Date <> date('now') order by CS_Date desc limit 1, 1) c1 on c1.Id = st.CallCard_PK \
					 left join (select Id, CS_Date from CallCard where Id not like '-%' and CS_Date <> date('now') order by CS_Date desc limit 1, 2) c2 on c2.Id = st.CallCard_PK \
					 left join (select Id, CS_Date from CallCard where Id not like '-%' and CS_Date <> date('now') order by CS_Date desc limit 1, 3) c3 on c3.Id = st.CallCard_PK \
					 group by st.Products__c"] 
					readToEndBy:@"Products__c"];
	
	
	self.navigationItem.rightBarButtonItem = self.nextButton;
	
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

-(void)save:(id)sender{
	
	UITextField *ui = (UITextField *)sender;
	
	UITableViewCell *cell = (UITableViewCell *)[ui lookupFor:[UITableViewCell class]];
	
	NSMutableDictionary *_data = nil;
	
	if([self.callcard_data objectForKey:cell.reuseIdentifier] == nil){
		
		// use self guid for new insert same as call card. So later can be refer		
		_data = [NSMutableDictionary dictionaryWithObjectsAndKeys:
				 @"-", @"Id", 
				 cell.reuseIdentifier, @"prod_db_id__c", 
				 self.accountId, @"AccountId__c", 
				 [self.callcard coalesce:@"Id", @"Name", nil], @"CallCard_PK", 
				 nil];
			
	}
	else{
		_data = [NSMutableDictionary dictionaryWithDictionary:[self.callcard_data objectForKey:cell.reuseIdentifier]];
	}
	
	NSString *target = nil;
	
	switch (ui.tag) {
		case CC_TAG_ON_SHELF:
			target = @"OnShelf";
			break;
			
		case CC_TAG_IN_STOCK:
			target = @"InStock";
			break;
	}
	
	if(ui.text.length == 0){
		[_data setObject:@"0" forKey:target];
	}
	else{
		[_data setObject:ui.text forKey:target];
	}

	
	[self.callcard_data setObject:_data forKey:cell.reuseIdentifier];	
		
}

-(IBAction)next:(id)sender{
	
	OVDatabase *db = [OVDatabase sharedInstance];
	
	[db executeUpdate:@"delete from Upload where planId = ?", self.planId];
	
	// save call card
	[db sfInsertInto:@"CallCard" withData:self.callcard];
	
	// save call card stock
	[[self.callcard_data allValues] enumerateObjectsUsingBlock:^(NSDictionary *data, NSUInteger index, BOOL *stop){
		[db sfInsertInto:@"CallCard_Stock" withData:data];
	}];
}

@end
