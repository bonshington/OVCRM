//
//  OVSyncController+OVSyncProtocal.m
//  OVCRM
//
//  Created by Apple on 09/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OVSyncController.h"
#import "OVMenuController.h"

@implementation OVSyncController (OVSyncProtocal)

-(void)updateStatus:(NSString *)status{
    [self.tableView cellForRowAtIndexPath:self.processing].detailTextLabel.text = status;
}

-(void)done{
    
    UITableViewCell *done = [self.tableView cellForRowAtIndexPath:self.processing];
    done.accessoryType = UITableViewCellAccessoryCheckmark;
    
    self.processing = [NSIndexPath indexPathForRow:(self.processing.row + 1) 
                                         inSection:self.processing.section];
    
    if([self.tableView cellForRowAtIndexPath:self.processing] == nil){
        self.processing = [NSIndexPath indexPathForRow:0
                                             inSection:self.processing.section + 1];
    }
    
    if([self.tableView cellForRowAtIndexPath:self.processing] != nil){
        [self sync];
    }
	else{
		
		// All synced
		
		self.processing = nil;
		
		// update last sync
		NSString *today = [[NSDate date] format:@"yyyy-MM-dd"];

		[[OVDatabase sharedInstance] executeQuery:@"update Parameter set val = ? where tag = 'CONFIG' key = 'LAST_SYNC' ", today];
		
		[[AppDelegate sharedInstance].user setValue:today
											 forKey:@"lastSyncDate"];
		
		
		// refresh things
		OVMenuController *menu = (OVMenuController *)[AppDelegate sharedInstance].master;
		[menu setActive:YES];
		[menu reloadData];
		
		[self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
		
	}
}

@end
