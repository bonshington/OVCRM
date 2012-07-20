//
//  SFUser.m
//  OVCRM
//
//  Created by Sopon Srisummasheep on 7/14/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import "SFUser.h"
#import "AppDelegate.h"

@implementation SFUser

-(NSString *) sfName{
	return @"User";
}

-(NSString *) sqlName{
	return @"User";
}

-(NSDictionary *)schema{
	return [NSDictionary dictionaryWithObjectsAndKeys:
			@"TEXT", @"Route_No__c", 
			@"TEXT", @"AboutMe",
			@"TEXT", @"IsActive",
			@"TEXT", @"Name",
			nil];
}

-(NSDictionary *) mapping{
	return [NSDictionary new];
}

-(void) sync:(id<OVSyncProtocal>)_controller {
	
	NSString *userId = [[AppDelegate sharedInstance].user objectForKey:@"userId"];
	
	[super sync:_controller where:[NSString stringWithFormat:@"Id = '%@'", userId]];
}

@end
