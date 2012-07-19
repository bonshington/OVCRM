//
//  OVMenuController+CallVisit.m
//  OVCRM
//
//  Created by Apple on 03/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OVMenuController.h"
#import "CallCard.h"

@implementation OVMenuController (CallVisit)


-(void) checkin{
    
	OVDatabase *db = [OVDatabase sharedInstance];
	
	FMResultSet *result = [db executeQuery:@"select Id from Account where Id in (select Account_Id from Plan where Id = ?)", self.checkinEventId];
	
	[result next];
	self.checkedAccountId = [result stringForColumnIndex:0];
		
	if(self.checkedAccountId != nil){
		
		NSDictionary *userData = [AppDelegate sharedInstance].user;
		
		[db sfInsertInto:@"Event" 
				withData:[NSDictionary dictionaryWithObjectsAndKeys:
						  self.checkinEventId, @"Id", 
						  [[NSDate date] SFString], @"Time_in__c",
						  [userData objectForKey:@"lat"], @"Latitude__c",
						  [userData objectForKey:@"lng"], @"Longtitude__c",
						  nil]];
	}
	
	[self reloadData];
	
	CallCard * nextView = [[CallCard alloc]initWithNibName:@"CallCard" bundle:nil];
    [nextView setPlan_ID:self.checkinEventId];
    [nextView setAccount_ID:self.checkedAccountId];
	
	[AppDelegate sharedInstance].checkin = [NSDictionary dictionaryWithObjectsAndKeys:
											self.checkinEventId, @"PlanId",
											self.checkedAccountId, @"AccountId",
											nil];
	
    [[AppDelegate sharedInstance].detail pushViewController:nextView animated:YES];
	
}

-(void) checkout{
    
	OVDatabase *db = [OVDatabase sharedInstance];
	
	[db executeUpdate:@"update Plan set Visit_TimeOut = datetime('now', 'localtime') where Id = ?", self.checkinEventId];
	[db sfInsertInto:@"Event" 
			withData:[NSDictionary dictionaryWithObjectsAndKeys:
					  self.checkinEventId, @"Id", 
					  [[NSDate date] SFString], @"Time_Out__c",
					  nil]];
	
	self.checkedAccountId = nil;
	
	[[AppDelegate sharedInstance].detail popToRootViewControllerAnimated:YES];
	
	[AppDelegate sharedInstance].checkin = nil;
	
	// dispay summary?
	
	[self reloadData];
}

@end
