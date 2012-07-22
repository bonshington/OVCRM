//
//  OVPlanViewController.m
//  OVCRM
//
//  Created by Sopon Srisummasheep on 7/22/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import "OVPlanViewController.h"


@implementation OVPlanViewController

@synthesize tableView, saveButton, datePicker, account, pickerView, textArea;


- (void)viewDidLoad{
    [super viewDidLoad];
    
	self.navigationItem.rightBarButtonItem = self.saveButton;
	
	self.account = [[[OVDatabase sharedInstance] executeQuery:@"select Id, Name, Addr1__c, Amphur__c from Account where Status__c = 'Active' order by Name"] readToEndBy:@"Id"];
	
	tapped = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissDatePicker:)];
    tapped.numberOfTapsRequired = 1;
	
	pickerInactiveFrame = CGRectMake(0
									 , 704
									 , self.datePicker.frame.size.width
									 , self.datePicker.frame.size.height);
	
	
	visitTypes = [NSArray arrayWithObjects:
				  @"",
				  @"Meet & Greet", 
				  @"Collection Only", 
				  @"Full Call", 
				  nil];
	
	self.navigationItem.rightBarButtonItem = self.saveButton;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
	return (interfaceOrientation == UIDeviceOrientationLandscapeRight) || (interfaceOrientation == UIDeviceOrientationLandscapeLeft);
}

-(IBAction)save:(id)sender{
	
	NSIndexPath *selectedAccount = [[self.tableView.indexPathsForSelectedRows where:^BOOL(NSIndexPath *each){
		return each.section == 2;
	}] objectAtIndex:0];
	
	
	UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:selectedAccount];
	
	[[OVDatabase sharedInstance] sfInsertInto:@"Plan" 
									 withData:[NSDictionary dictionaryWithObjectsAndKeys:
											   ((UITextView *)[self.tableView viewWithTag:tagForInput forRow:0 inSection:1]).text, @"Description", 
											   [start SFString], @"StartDateTime",
											   [end SFString], @"EndDateTime",
											   cell.reuseIdentifier, @"WhatId",
											   cell.textLabel.text, @"Account_Name__c",
											   @"Visit", @"Subject",
											   [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]].detailTextLabel.text, @"Visit_Type__c",
											   @"IPAD", @"Source_System__c",
											   @"-", @"Id",
											   nil]];
}

-(void)validate{
	
	BOOL passed = 
	   // has start < date
		(start != nil && end != nil && [start compare:end] != NSOrderedDescending)
	   
	   // has type
	   && [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]].detailTextLabel.text.length > 0
	   
	   // has account
		&& [self.tableView.indexPathsForSelectedRows where:^BOOL(NSIndexPath *each){ return each.section == 2;}].count > 0;
	
	self.saveButton.enabled = passed;
	
	
	if([start compare:end] == NSOrderedDescending){
		end = nil;
		UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
		cell.detailTextLabel.text = @"";
		[[cell viewWithTag:tagForDateTime] removeFromSuperview];
	}
}

@end
