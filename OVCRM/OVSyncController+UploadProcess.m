//
//  OVSyncController+UploadProcess.m
//  OVCRM
//
//  Created by Sopon Srisummasheep on 7/14/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import "OVSyncController.h"

@implementation OVSyncController (UploadProcess)

-(void) upsert:(NSString *)uploadPk{
	
	if(self.upload == nil || self.upload.count == uploading){
		[self done];
	}
	
	
	[self updateStatus:@"Preparing"];
	
	NSDictionary *data = [self.upload objectAtIndex:uploading];
	
	NSMutableDictionary *json = [NSMutableDictionary dictionaryWithDictionary:[SFJsonUtils objectFromJSONString:[data objectForKey:@"json"]]];
	
	NSString *obj = [data objectForKey:@"sObject"];
	
	self.sending = [NSDictionary dictionaryWithObjectsAndKeys:
					obj, @"sObject", 
					json, @"json",
					nil];
	
	SFRestRequest *request = nil;
	
	
	if([[data objectForKey:@"Id"] hasPrefix:@"-"]){
		// create
		
		if([obj isEqualToString:@"Stock__c"]){
			
			if([[json objectForKey:@"Call_Card__c"] hasPrefix:@"-"]){
				
				NSString *guid = [json objectForKey:@"Call_Card__c"] ;
				
				[json setValue:[self.mapping objectForKey:guid] forKey:@"Call_Card__c"];
			}
		}
		
		request = [[SFRestAPI sharedInstance] requestForCreateWithObjectType:obj
																	  fields:json];
	}
	else{
		request = [[SFRestAPI sharedInstance] requestForUpdateWithObjectType:obj
																	objectId:[data objectForKey:@"Id"] 
																	  fields:json];
	}
	
	[AppDelegate sharedInstance].sync = self;
	
    [[SFRestAPI sharedInstance] send:request delegate:self];
	
	[self updateStatus:@"Sending data"];
}

@end
