//
//  OVMerchandiseViewController+Action.m
//  OVCRM
//
//  Created by Sopon Srisummasheep on 7/21/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import "OVMerchandiseViewController.h"
#import "OVGoodReturnViewController.h"

@implementation OVMerchandiseViewController (Action)

-(IBAction)change:(id)sender{
	
	UITextField *ui = (UITextField *)sender;
	
	UITableViewCell *cell = (UITableViewCell *)[ui lookupFor:[UITableViewCell class]];
	
	NSMutableDictionary *_data = [self.data objectForKey:cell.reuseIdentifier];
	
	if(_data == nil){
		
		NSDictionary *planData = [[AppDelegate sharedInstance].checkin objectForKey:@"PlanData"];
		
		// use self guid for new insert same as call card. So later can be refer		
		_data = [NSMutableDictionary dictionaryWithObjectsAndKeys:
				 @"-", @"Id", 
				 cell.reuseIdentifier, @"prod_db_id__c", 
				 self.accountId, @"Account__c", 
				 self.planId, @"plan_id__c", 
				 [planData objectForKey:@"ActivityDate"], @"Date__c",
				 cell.textLabel.text, @"Name",
				 nil];
		
	}
	else{
		_data = [NSMutableDictionary dictionaryWithDictionary:[self.data objectForKey:cell.reuseIdentifier]];
	}
	
	NSString *target = nil;
	
	switch (ui.tag) {
		case tagForOnShelfPrice:
			target = @"On_Shelf_Price__c";
			break;
			
		case tagForFacing:
			target = @"Shelf_Share__c";
			break;
	}
	
	if(ui.text.length == 0){
		[_data setObject:@"0" forKey:target];
	}
	else{
		[_data setObject:ui.text forKey:target];
	}
	
	
	[self.data setObject:_data forKey:cell.reuseIdentifier];	
	
}

-(IBAction)next:(id)sender{
	
	[self save:sender];
	
	[self.navigationController pushViewController:[[OVGoodReturnViewController alloc] initWithPlanId:self.planId 
																						   accountId:self.accountId]
										 animated:YES];
}

-(IBAction)checkout:(id)sender{
	
	[self save:sender];
	
	[super checkout];
	
	[self dismissModalViewControllerAnimated:YES];
}

-(IBAction)save:(id)sender{
	OVDatabase *db = [OVDatabase sharedInstance];
	
	[db executeUpdate:@"delete from Upload where planId = ? and sObject = 'Merchandise__c'", self.planId];
	
	// save call card stock
	[[self.data allValues] enumerateObjectsUsingBlock:^(NSDictionary *data, NSUInteger index, BOOL *stop){
		[db sfInsertInto:@"Merchandise__c" withData:data];
	}];
}


@end
