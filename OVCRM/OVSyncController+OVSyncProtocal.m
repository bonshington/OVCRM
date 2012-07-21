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
	
	if(done.tag == tagForCellSyncUpload){
		self.progress.progress = 1.0;
		done.detailTextLabel.text = @"Completed";
	}
	else{
		done.accessoryType = UITableViewCellAccessoryCheckmark;
    }
	
    self.processing = [NSIndexPath indexPathForRow:(self.processing.row + 1) 
                                         inSection:self.processing.section];
    
    if([self.tableView cellForRowAtIndexPath:self.processing] == nil){
		
		// increment to next visible cell
        self.processing = [NSIndexPath indexPathForRow:0
                                             inSection:self.processing.section + 1];
		
    }
    
    if([self.tableView cellForRowAtIndexPath:self.processing] != nil){
		
		[self.tableView scrollToRowAtIndexPath:self.processing 
							  atScrollPosition:UITableViewScrollPositionMiddle 
									  animated:YES];
		
        [self sync];
    }
	else{
		
		// All synced
		
		self.processing = nil;
		
		// update last sync
		NSString *today = [[NSDate date] format:@"yyyy-MM-dd"];
		
		NSLog(@"Sync complete for: %@", today);

		[[OVDatabase sharedInstance] executeUpdate:@"update Parameter set label = ? where tag = 'CONFIG' and key = 'LAST_SYNC'", today];
		
		// refresh things
		OVMenuController *menu = (OVMenuController *)[AppDelegate sharedInstance].master;
		[menu setActive:YES];
		[menu reloadData];
		
		[self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
		
		
		[self.navigationController popViewControllerAnimated:YES];
	}
}

-(void) error:(NSString *)msg{
	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error Occurred" 
													message:[NSString stringWithFormat:@"Please try to sync again later. %@", msg ]
												   delegate:self
										  cancelButtonTitle:@"OK" 
										  otherButtonTitles:nil];
	
	[alert show];
	
	[self.navigationController popViewControllerAnimated:YES];
}

@end
