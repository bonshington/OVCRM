//
//  OVSyncController+OVSyncProtocal.m
//  OVCRM
//
//  Created by Apple on 09/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OVSyncController.h"

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
}

@end
