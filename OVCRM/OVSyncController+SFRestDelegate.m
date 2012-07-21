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
    
    NSLog(@"Got response for: %@", [self class]);
    
    [self updateStatus:@"Data transmitted"];
	
	
	if(jsonResponse != nil){
		
		[self.mapping setObject:[jsonResponse objectForKey:@"id"] forKey:[self.upload objectAtIndex:uploading forKey:@"Id"]];
	}
    
    OVDatabase *db = [OVDatabase sharedInstance];
	
	[db executeUpdate:@"update Upload set syncTime = datetime('now', 'localtime') where pk = ?", [self.upload objectAtIndex:uploading forKey:@"pk"]];
	
	//fetch next upload
	if(uploading + 1 < self.upload.count){
		self.progress.progress = (float)(uploading + 1) / (float)self.upload.count;
		
		[self upsert:[self.upload objectAtIndex:++uploading forKey:@"pk"]];
	}
	else {
		[self done];
	}
}

- (void)request:(SFRestRequest *)request didFailLoadWithError:(NSError*)error{
    
	[self error:error.localizedDescription];
}

- (void)requestDidCancelLoad:(SFRestRequest *)request{
    [self error:@"Canceled"];
}

- (void)requestDidTimeout:(SFRestRequest *)request{
    [self error:@"Timeout..."];
}

@end
