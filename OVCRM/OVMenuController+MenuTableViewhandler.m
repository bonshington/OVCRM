//
//  OVRootViewController+Menu.m
//  OVCRM
//
//  Created by Apple on 03/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OVMenuController.h"
#import "OVWebViewController.h"
#import "OVSyncController.h"

@implementation OVMenuController (MenuTableViewhandler)

#pragma mark - Sections

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView 
titleForHeaderInSection:(NSInteger)section{

    switch(section){
			
		case 0: return @"Visit";
			
		case 1: return @"SalesForce";
	}
    
    return @"???";
}

- (NSInteger)tableView:(UITableView *)tableView 
 numberOfRowsInSection:(NSInteger)section{
    
    switch(section){
		case 0: return self.todayPlan.count;
			
		case 1: return 1;
			
		default: return 0;
	}
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch(indexPath.section){
		case 0: return [self tableView:tableView planForRowAtIndexPath:indexPath];
			
		case 1: return [self tableView:tableView sfForRowAtIndexPath:indexPath];
			
		default: return nil;
	}
    
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AppDelegate *app = [AppDelegate sharedInstance];
    UITableViewCell *tappedCell = [tableView cellForRowAtIndexPath:indexPath];
    
    switch (tappedCell.tag) {
        case tagForCellPlanVisit:{
            
			if(self.checkedAccountId != nil)
				return;
			
			[app.detail popToRootViewControllerAnimated:NO];
			
            NSString *accountId = ((UILabel *)[tappedCell viewWithTag:tagForSFAccountId]).text;
            self.checkinEventId = ((UILabel *)[tappedCell viewWithTag:tagForSFEventId]).text;
			
            UIBarButtonItem *checkin = nil;
			
			
			if(self.checkedAccountId == nil){
				checkin = [[UIBarButtonItem alloc] initWithTitle:@"Check-in"
														   style:UIBarButtonItemStyleDone 
														  target:self 
														  action:@selector(checkin)];
			}                           
            
            // show account with checkin
			[self invokeSFObject:@"Account" 
					withMustache:[SFAccount selectAccountContextOf:accountId] 
			  withRightBarButton:checkin];
            
        }break;
            
        case tagForCellSF:
			
			if(self.checkedAccountId != nil)
				return;
			
			[app.detail popToRootViewControllerAnimated:NO];
			
            [self setActive:NO];
            [app.detail pushViewController:[[OVSyncController alloc] initWithStyle:UITableViewStyleGrouped] animated:YES];
            break;
    }
}


- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	
	if(tableView.selectedCell != nil && [tableView viewWithTag:tagForLockStatus] != nil){
		return [tableView indexPathForSelectedRow];
	}
	else {
		return indexPath;
	}
}


@end
