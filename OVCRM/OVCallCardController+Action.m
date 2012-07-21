//
//  OVCallCardController+Action.m
//  OVCRM
//
//  Created by Sopon Srisummasheep on 7/21/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import "OVCallCardController.h"
#import "OVMerchandiseViewController.h"

@implementation OVCallCardController (Action)

-(IBAction)change:(id)sender{
	
	UITextField *ui = (UITextField *)sender;
	
	UITableViewCell *cell = (UITableViewCell *)[ui lookupFor:[UITableViewCell class]];
	
	NSMutableDictionary *_data = [self.callcard_data objectForKey:cell.reuseIdentifier];
	
	if(_data == nil){
		
		// use self guid for new insert same as call card. So later can be refer		
		_data = [NSMutableDictionary dictionaryWithObjectsAndKeys:
				 @"-", @"Id", 
				 cell.reuseIdentifier, @"prod_db_id__c", 
				 self.accountId, @"AccountID__c", 
				 [self.callcard coalesce:@"Id", @"Name", nil], @"Call_Card__c", 
				 nil];
		
	}
	else{
		_data = [NSMutableDictionary dictionaryWithDictionary:[self.callcard_data objectForKey:cell.reuseIdentifier]];
	}
	
	NSString *target = nil;
	
	switch (ui.tag) {
		case tagForOnShelf:
			target = @"Quantity_Remain__c";
			break;
			
		case tagForInStock:
			target = @"In_Stock__c";
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
	
	[self save:sender];
	
	[self.navigationController pushViewController:[[OVMerchandiseViewController alloc] initWithPlanId:self.planId 
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
	
	[db executeUpdate:@"delete from Upload where planId = ? and (sObject = 'Call_Card__c' or sObject = 'Stock__c')", self.planId];
	
	// save call card
	[db sfInsertInto:@"Call_Card__c" withData:self.callcard];
	
	// save call card stock
	[[self.callcard_data allValues] enumerateObjectsUsingBlock:^(NSDictionary *data, NSUInteger index, BOOL *stop){
		[db sfInsertInto:@"Stock__c" withData:data];
	}];
}

@end
