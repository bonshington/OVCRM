//
//  OVOrderTakingViewController+Action.m
//  OVCRM
//
//  Created by Apple on 23/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OVOrderTakingViewController.h"

@implementation OVOrderTakingViewController (Action)

-(IBAction)change:(id)sender{
	UITableViewCell *cell = nil;
	
	if([sender isKindOfClass:[UITableViewCell class]])
		cell = (UITableViewCell *)sender;
	else {
		cell = (UITableViewCell *)[(UIView *)sender lookupFor:[UITableViewCell class]];
	}
	
	NSDictionary *_temp = [self.detail objectForKey:cell.reuseIdentifier];
	NSMutableDictionary *_detail = nil;
	
	if(_temp == nil){
		
		// add detail. Sub product will be add in summary manager	
		_detail = [NSMutableDictionary dictionaryWithObjectsAndKeys:
				 @"-", @"Id", 
				 cell.reuseIdentifier, @"Products_Database_ID__c", 
				 accountId, @"Account_ID__c", 
//				 cell.textLabel.text, @"Name", 
				 @"IPAD", @"Source_System__c",
				 @"0", @"List_Price__c",
				 [self.data objectForKey:@"Id"], @"Order_Taking__c",
				 cell.textLabel.text, @"Product_Category__c",
				 cell.detailTextLabel.text, @"Product_Code__c",
				 nil];
		
	}
	else{
		_detail = [NSMutableDictionary dictionaryWithDictionary:_temp];
	}
	
	[_detail setObject:((UILabel *)[cell viewWithTag:tagForInput]).text 
				forKey:@"Quantity__c"];	
	
	[self.detail setObject:_detail forKey:cell.reuseIdentifier];	
	
}


-(IBAction)next:(id)sender{
	
	[self save:sender];
	
	[self showSummary:sender];
}

-(IBAction)checkout:(id)sender{
	
	[self save:sender];
	
	[[AppDelegate sharedInstance] checkout];
	
}

-(IBAction)save:(id)sender{
	
	// ?? save data
	// tell summary to save detail
	
}

@end
