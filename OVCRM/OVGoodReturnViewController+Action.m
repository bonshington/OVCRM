//
//  OVGoodReturnViewController+Action.m
//  OVCRM
//
//  Created by Sopon Srisummasheep on 7/22/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import "OVGoodReturnViewController.h"
#import "InvoiceList.h"
#import "OVOrderTakingViewController.h"


@implementation OVGoodReturnViewController (Action)

-(IBAction)change:(id)sender{
	
	UITableViewCell *cell = nil;
	
	if([sender isKindOfClass:[UITableViewCell class]])
		cell = (UITableViewCell *)sender;
	else {
		cell = (UITableViewCell *)[(UIView *)sender lookupFor:[UITableViewCell class]];
	}
	
	NSDictionary *_temp = [self.data objectForKey:cell.reuseIdentifier];
	NSMutableDictionary *_data = nil;
	
	if(_temp == nil){
		
		NSDictionary *planData = [[AppDelegate sharedInstance].checkin objectForKey:@"PlanData"];
		
		// use self guid for new insert same as call card. So later can be refer		
		_data = [NSMutableDictionary dictionaryWithObjectsAndKeys:
				 @"-", @"Id", 
				 cell.reuseIdentifier, @"prod_db_id__c", 
				 self.accountId, @"Account__c", 
				 cell.textLabel.text, @"Name", 
				 @"IPAD", @"Source_System__c",
				 [planData objectForKey:@"ActivityDate"], @"Return_Date__c",
				 nil];
		
	}
	else{
		_data = [NSMutableDictionary dictionaryWithDictionary:_temp];
	}
	
	NSString *val1 = ((UITextField *)[cell viewWithTag:tagForReturnReason]).text;
	if(val1 != nil)
		[_data setObject:((UILabel *)[cell viewWithTag:tagForReturnReason]).text 
				  forKey:@"Reason_for_Return__c"];
	
	
	NSString *val2 = ((UITextField *)[cell viewWithTag:tagForReturnQty]).text;
	if(val2 != nil)
		[_data setObject:((UITextField *)[cell viewWithTag:tagForReturnQty]).text
				  forKey:@"Shelf_Share__c"];
	
	
	[self.data setObject:_data forKey:cell.reuseIdentifier];	
	
}


-(IBAction)next:(id)sender{
	
	[self save:sender];
	
	InvoiceList *controller = [InvoiceList new];
	
	//OVOrderTakingViewController *controller = [[OVOrderTakingViewController alloc] initWithPlanId:self.planId accountId:self.accountId];
	
	controller.plan_ID = self.planId;
	controller.account_ID = self.accountId;
	
	[self.navigationController pushViewController:controller
										 animated:YES];
	//InvoiceList
}

-(IBAction)checkout:(id)sender{
	
	[self save:sender];
	
	[super checkout];
	
	[self dismissModalViewControllerAnimated:YES];
}

-(IBAction)save:(id)sender{
	OVDatabase *db = [OVDatabase sharedInstance];
	
	[db executeUpdate:@"delete from Upload where planId = ? and sObject = 'Goods_Return__c'", self.planId];
	
	[[self.data allValues] enumerateObjectsUsingBlock:^(NSDictionary *data, NSUInteger index, BOOL *stop){
		[db sfInsertInto:@"Goods_Return__c" withData:data];
	}];
	
	[[AppDelegate sharedInstance].checkin setObject:self.data forKey:@"GoodReturn"];
}

@end
