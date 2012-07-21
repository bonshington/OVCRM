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
    return 3;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{

    switch (section) {
			
		case OVSYNC_SECTION_MY_DATA: return @"My Information";
			
        case OVSYNC_SECTION_UPLOAD: return @"Upload";
        
        case OVSYNC_SECTION_DOWNLOAD: return @"Download";
    }
    
    return nil;
}

#pragma mark - rows

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    switch (section) {
			
		case OVSYNC_SECTION_MY_DATA: return 1;
			
        case OVSYNC_SECTION_UPLOAD: return 1;
            
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
				
			case OVSYNC_SECTION_MY_DATA:
				cell.textLabel.text = @"My Information";
                cell.detailTextLabel.text = @"...";
                cell.accessoryType = UITableViewCellAccessoryNone;
                cell.tag = tagForCellSyncMyData;
                break;
				
            case OVSYNC_SECTION_UPLOAD:{
				
				cell.tag = tagForCellSyncUpload;
				
				self.progress = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
				
				self.progress.frame = CGRectMake(150, 17, 500, 10);
				self.progress.progress = 0;
				
				[cell addSubview:self.progress];
                break;
			}
            case OVSYNC_SECTION_DOWNLOAD:
                cell.textLabel.text = [self.download keyAtIndex:indexPath.row];
                cell.detailTextLabel.text = @"...";
                cell.accessoryType = UITableViewCellAccessoryNone;
                cell.tag = tagForCellSyncDownload;
                break;
        }
        
    }
    
    return cell;
}



@end
