//
//  AppDelegate+Action.m
//  OVCRM
//
//  Created by Apple on 24/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "OVStepsController.h"
#import "OVCallCardController.h"

@implementation AppDelegate (Action)


-(void) checkinAccount:(NSString *)_accountId withPlan:(NSString *)_planId{
    
	planId = _planId;
	accountId = _accountId;
	
	
	NSArray *result = [[self.db executeQuery:@"select * from Account where Id in (select Account_Id from Plan where Id = ?)", planId] readToEnd];
	
	if(result != nil && result.count > 0){
		
		accountId = [result objectAtIndex:0 forKey:@"Id"];
		
		NSDictionary *userData = [AppDelegate sharedInstance].user;
		
		[self.db sfInsertInto:@"Plan" 
					 withData:[NSDictionary dictionaryWithObjectsAndKeys:
							   planId, @"Id", 
							   [[NSDate date] SFString], @"Time_in__c",
							   [userData objectForKey:@"lat"], @"Latitude__c",
								[userData objectForKey:@"lng"], @"Longtitude__c",
						  nil]];
	}
	
	NSArray *planData = [[self.db executeQuery:@"select * from Plan where Id = ?", planId] readToEnd];
	NSArray *myself = [[self.db executeQuery:@"select * from User limit 1"] readToEnd];
	
	NSMutableDictionary *checkinData = [NSMutableDictionary dictionaryWithObjectsAndKeys:
										[myself objectAtIndex:0 forKey:@"Name"], @"myself",
										planId			, @"PlanId",
										[planData objectAtIndex:0]	, @"PlanData",
										accountId		, @"AccountId",
										[result objectAtIndex:0]	, @"AccountData",
										[NSDate date]				, @"time",
										
										nil];
	
	self.checkin = checkinData;
	
	
	//[[AppDelegate sharedInstance].detail popToRootViewControllerAnimated:NO];
	
	
	UIViewController *firstStep = [[OVCallCardController alloc] initWithPlanId:planId 
																	 accountId:accountId];
	
	OVStepsController *steps = [[OVStepsController alloc] initWithRootViewController:firstStep];
	
	[self.root presentModalViewController:steps 
								 animated:YES];
	
	
}

-(void) checkout{
    
	[self.db executeUpdate:@"update Plan set Visit_TimeOut = datetime('now', 'localtime') where Id = ?", planId];
	
	[self.db sfInsertInto:@"Event" 
			withData:[NSDictionary dictionaryWithObjectsAndKeys:
					  planId, @"Id", 
					  [[NSDate date] SFString], @"Time_Out__c",
					  nil]];
	
	accountId = nil;
	
	[[AppDelegate sharedInstance].detail popToRootViewControllerAnimated:YES];
	
	[AppDelegate sharedInstance].checkin = nil;
	
	// dispay summary?
	
	//[self reloadData];
}

@end
