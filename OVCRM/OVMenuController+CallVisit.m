//
//  OVMenuController+CallVisit.m
//  OVCRM
//
//  Created by Apple on 03/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OVMenuController.h"
#import "OVStepsController.h"
#import "OVCallCardController.h"
#import "CallCard.h"

@implementation OVMenuController (CallVisit)


-(void) checkin{
    
	OVDatabase *db = [OVDatabase sharedInstance];
	
	NSArray *result = [[db executeQuery:@"select * from Account where Id in (select Account_Id from Plan where Id = ?)", self.checkinEventId] readToEnd];
	
	if(result != nil && result.count > 0){
		
		self.checkedAccountId = [result objectAtIndex:0 forKey:@"Id"];
		
		NSDictionary *userData = [AppDelegate sharedInstance].user;
		
		[db sfInsertInto:@"Plan" 
				withData:[NSDictionary dictionaryWithObjectsAndKeys:
						  self.checkinEventId, @"Id", 
						  [[NSDate date] SFString], @"Time_in__c",
						  [userData objectForKey:@"lat"], @"Latitude__c",
						  [userData objectForKey:@"lng"], @"Longtitude__c",
						  nil]];
	}
	
	[self reloadData];
	
	NSArray *planData = [[db executeQuery:@"select * from Plan where Id = ?", self.checkinEventId] readToEnd];
	NSArray *myself = [[db executeQuery:@"select * from User limit 1"] readToEnd];
	
	NSDictionary *checkinData = [NSDictionary dictionaryWithObjectsAndKeys:
								 [myself objectAtIndex:0 forKey:@"Name"], @"myself",
								 self.checkinEventId		, @"PlanId",
								 [planData objectAtIndex:0]	, @"PlanData",
								 self.checkedAccountId		, @"AccountId",
								 [result objectAtIndex:0]	, @"AccountData",
								 [NSDate date]				, @"time",
								 
								 nil];
	
	[AppDelegate sharedInstance].checkin = checkinData;
	
	
	//[[AppDelegate sharedInstance].detail popToRootViewControllerAnimated:NO];
	
	
	OVStepsController *steps = [[OVStepsController alloc] initWithRootViewController:[[OVCallCardController alloc] initWithPlanId:self.checkinEventId accountId:self.checkedAccountId]];
	
	[[AppDelegate sharedInstance].root presentModalViewController:steps animated:YES];
	
	
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
