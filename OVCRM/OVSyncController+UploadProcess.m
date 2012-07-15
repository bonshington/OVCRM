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
	
	[self updateStatus:@"Preparing"];
	
	NSDictionary *data = [SFJsonUtils objectFromJSONString:[self.tableView labelInSelectdCellWithTag:tagForUploadId].text];
	
	[self upsertInto:[self.tableView labelInSelectdCellWithTag:tagForUploadObject].text 
				toId:[self.tableView labelInSelectdCellWithTag:tagForUploadId].text 
			  values:data];
}

-(void) upsertInto:(NSString *)sfObject toId:(NSString *)objectId values:(NSDictionary *)values{
	
	SFRestRequest *request = [[SFRestAPI sharedInstance] requestForUpsertWithObjectType:sfObject externalIdField:@"Id" externalId:objectId fields:values];
	
    [AppDelegate sharedInstance].sync = self;
	
    [[SFRestAPI sharedInstance] send:request delegate:self];
	
	[self updateStatus:@"Sending data"];
	
}

@end
