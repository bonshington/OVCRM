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
	
	FMResultSet *result = [db executeQuery:@"select Id from Account where Id in (select WhatId from Event where Id = ?)", self.checkinEventId];
	
	[result next];
	self.checkedAccountId = [result stringForColumnIndex:0];
		
	if(self.checkedAccountId != nil){
		[db sfInsertInto:@"Checkin" 
				withData:[NSDictionary dictionaryWithObjectsAndKeys:
						  self.checkedAccountId, @"AccountId",
						  self.checkinEventId, @"EventId", 
						  @"my id", @"UserId",
						  @"date time", @"time",
						  @"10101", @"lat",
						  @"1001", @"lng",
						  @"10101", @"radius",
						  nil]];
	}
	
	[self reloadData];
	
	CallCard * nextView = [[CallCard alloc]initWithNibName:@"CallCard" bundle:nil];
    [nextView setPlan_ID:self.checkinEventId];
    [nextView setAccount_ID:self.checkedAccountId];
	
    [[AppDelegate sharedInstance].detail pushViewController:nextView animated:YES];
}

-(void) checkout{
    
}


-(void) plan{
    
}

-(void) viewAccountId:(char *) accountId{
    
}

-(void) pushViewController:(char *)name{
    
}

@end
