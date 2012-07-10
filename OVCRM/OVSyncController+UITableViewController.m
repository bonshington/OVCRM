//
//  OVSyncController+TableViewController.m
//  OVCRM
//
//  Created by Apple on 09/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OVSyncController.h"



@implementation OVSyncController (UITableViewController)

#pragma mark - Section

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{

    switch (section) {
        case OVSYNC_SECTION_UPLOAD: return @"Upload";
        
        case OVSYNC_SECTION_DOWNLOAD: return @"Download";
    }
    
    return nil;
}

#pragma mark - rows

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    switch (section) {
        case OVSYNC_SECTION_UPLOAD: return [self.upload count];
            
        case OVSYNC_SECTION_DOWNLOAD: return [self.download count];
    }
    
    return 0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *cellId = [NSString stringWithFormat:@"%d:%d", indexPath.section, indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if(cell == nil){
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
        
        switch (indexPath.section) {
            case OVSYNC_SECTION_UPLOAD:
                cell.textLabel.text = [[self.upload allKeys] objectAtIndex:indexPath.row];
                cell.detailTextLabel.text = @"...";
                cell.accessoryType = UITableViewCellAccessoryNone;
                cell.tag = tagForCellSyncUpload;
                break;
                
            case OVSYNC_SECTION_DOWNLOAD:
                cell.textLabel.text = [[self.download allKeys] objectAtIndex:indexPath.row];
                cell.detailTextLabel.text = @"...";
                cell.accessoryType = UITableViewCellAccessoryNone;
                cell.tag = tagForCellSyncDownload;
                break;
        }
        
        
        
    }
    
    return cell;
}

#pragma mark - Selection

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView selectRowAtIndexPath:self.processing animated:NO scrollPosition:UITableViewScrollPositionNone];
}

@end
