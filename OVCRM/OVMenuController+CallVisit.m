//
//  OVMenuController+CallVisit.m
//  OVCRM
//
//  Created by Apple on 03/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OVMenuController.h"

@implementation OVMenuController (CallVisit)


-(void) checkin{
    
	OVDatabase *db = [OVDatabase sharedInstance];
	
	FMResultSet *result = [db executeQuery:@"select Id from Account where Id in (select WhatId from Event where Id = ?)", self.checkinEventId];
	
	if(result.hasAnotherRow){
		[result next];
		self.checkedAccountId = [result stringForColumnIndex:0];
		
		if(self.checkedAccountId != nil){
			[db registerUpload:@"Checkin" withData:[NSDictionary dictionaryWithObjectsAndKeys:
													self.checkedAccountId, @"AccountId",
													self.checkinEventId, @"EventId", 
													@"my id", @"UserId",
													@"date time", @"time"
													nil]];
		}
	}
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
