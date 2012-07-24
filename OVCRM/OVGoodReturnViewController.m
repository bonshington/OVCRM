//
//  OVGoodReturnViewController.m
//  OVCRM
//
//  Created by Sopon Srisummasheep on 7/22/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import "OVGoodReturnViewController.h"


@implementation OVGoodReturnViewController

@synthesize data, pickerView;

- (void)viewDidLoad
{
	reasonsOfReturn = [NSArray arrayWithObjects:
					   @"",
					   @"Customer Reject", 
					   @"Damaged",
					   @"Expired",
					   @"Others",
					   @"Wrong Order",
					   nil];
	
	self.delegate = self;
	
	[self load];
	
    [super viewDidLoad];
    
	self.title = @"Market Hygiene";
	
	self.pickerView.frame = CGRectMake(self.tableView.frame.size.width
									   , 0
									   , self.pickerView.frame.size.width
									   , self.pickerView.frame.size.height);
	
	[self.view addSubview:self.pickerView];

	tapped = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidePicker:)];
    tapped.numberOfTapsRequired = 1;
}


-(void) load{
	
	OVDatabase *db = [OVDatabase sharedInstance];
	
	if(!db.open)
		[db open];
	
	NSMutableDictionary *merge = [NSMutableDictionary new];
	
	NSArray *resume = [[db executeQuery:@"select * from Upload where planId = ? and sObject = 'Goods_Return__c' and syncTime is null", self.planId] readToEnd];
	
	// resume
	if(resume != nil && resume.count > 0){
		
		[resume enumerateObjectsUsingBlock:^(NSDictionary *upload, NSUInteger index, BOOL *stop){
		
			NSDictionary *json = [SFJsonUtils objectFromJSONString:[upload objectForKey:@"json"]];
			
			[merge setObject:json forKey:[json objectForKey:@"prod_db_id__c"]];
		}];
	}
	
	
	NSArray *existing = [[db executeQuery:
							   @"select * from Goods_Return__c where Account__c = ? and Return_Date__c in (select ActivityDate from Plan where Id = ?)", self.accountId, self.planId] readToEnd];
	
	if(existing != nil && existing.count > 0){
		
		[existing enumerateObjectsUsingBlock:^(NSDictionary *row, NSUInteger index, BOOL *stop){
			[merge setObject:row forKey:[row objectForKey:@"prod_db_id__c"]];
		}];
		
		[db executeUpdate:@"delete from Upload where planId = ? and sObject = 'Goods_Return__c' and syncTime is null", self.planId];
	}
	
	self.data = merge;
	
}



- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
	
	[self hidePicker:textField];
	
	return YES;
}

@end
