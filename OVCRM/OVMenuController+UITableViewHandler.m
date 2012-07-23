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

#define MENU_VISIT_SECTION_HEIGHT 39

@implementation OVMenuController (UITableViewHandler)

#pragma mark - Sections

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
	
	switch(section){
			
		case 0: return 40;
			
		case 1: return 22;
	}
	
	return 0;
}

- (NSString *)tableView:(UITableView *)tableView 
titleForHeaderInSection:(NSInteger)section{

    switch(section){
			
		case 0: return @"Visit";
			
		case 1: return @"SalesForce";
	}
    
    return @"???";
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

	switch(section){
			
		case 0:{
			
			UIButton *button = [UIButton buttonWithType:UIButtonTypeContactAdd];
			
			button.frame = CGRectMake( tableView.frame.size.width - button.frame.size.width - (MENU_VISIT_SECTION_HEIGHT - button.frame.size.height)/2 - 5
									   , (44 - button.frame.size.height)/2
									   , button.frame.size.width
									   , button.frame.size.height);
			
			[button addTarget:self action:@selector(openPlan:) forControlEvents:UIControlEventTouchUpInside];
			
			
			UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 200, MENU_VISIT_SECTION_HEIGHT)];
			label.text = @"Visit";
			label.backgroundColor = [UIColor clearColor];
			label.font = [UIFont fontWithName:@"Helvetica-Bold" size:17];
			label.textColor = [UIColor colorWithRed:0.298039 green:0.337255 blue:0.423529 alpha:1];
			label.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
			label.shadowColor = [UIColor whiteColor];
			label.shadowOffset = CGSizeMake(0, 1);
			
		
			UIView *custom = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, MENU_VISIT_SECTION_HEIGHT)];
			custom.backgroundColor = [UIColor clearColor];
			custom.opaque = NO;
			
			[custom addSubview:label];
			[custom addSubview:button];
			
			
			return custom;
		};
			
		case 1: return nil;
	}
	
	return nil;
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
