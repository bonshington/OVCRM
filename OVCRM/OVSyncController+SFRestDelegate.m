//
//  OVSyncController+SFRestDelegate.m
//  OVCRM
//
//  Created by Sopon Srisummasheep on 7/14/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import "OVSyncController.h"

@implementation OVSyncController (SFRestDelegate)

- (void)request:(SFRestRequest *)request 
didLoadResponse:(id)jsonResponse{
    
    NSLog(@"Got response for: %@", self.class);
    
    [self updateStatus:@"Data transmitted"];
    
    OVDatabase *db = [OVDatabase sharedInstance];
	
	[db executeUpdate:@"update Upload set syncTime = date('now') where pk = ?", [self.tableView labelInSelectdCellWithTag:tagForUploadPk].text];
	
	[self done];
}

- (void)request:(SFRestRequest *)request didFailLoadWithError:(NSError*)error{
    [self updateStatus:@"Error !!"];
}

- (void)requestDidCancelLoad:(SFRestRequest *)request{
    [self updateStatus:@"Cancelled"];
}

- (void)requestDidTimeout:(SFRestRequest *)request{
    [self updateStatus:@"Timeout..."];
}

@end
