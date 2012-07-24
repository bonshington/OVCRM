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
			
            accountId = ((UILabel *)[tappedCell viewWithTag:tagForSFAccountId]).text;
            planId = ((UILabel *)[tappedCell viewWithTag:tagForSFEventId]).text;
			
            UIBarButtonItem *checkin = [[UIBarButtonItem alloc] initWithTitle:@"Check-in"
																		style:UIBarButtonItemStyleDone 
																	   target:self 
																	   action:@selector(checkin:)];
			
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


#pragma mark - Render



-(UITableViewCell *)tableView:(UITableView *)tableView planForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *data = [self.todayPlan objectAtIndex:indexPath.row];
    NSString *cellId = [NSString stringWithFormat:@"plan:%@", [data objectForKey:@"Id"]];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if(cell == nil){
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
        
        cell.textLabel.text = [data objectForKey:@"Account_Name"];
        cell.detailTextLabel.text = [data objectForKey:@"time"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.tag = tagForCellPlanVisit;
        
        [cell addSubview:[UILabel hiddenLabelForText:[data objectForKey:@"Account_ID"] withTag:tagForSFAccountId]];
        [cell addSubview:[UILabel hiddenLabelForText:[data objectForKey:@"Id"] withTag:tagForSFEventId]];
    }
	
    return cell;
}

-(UITableViewCell *)tableView:(UITableView *)tableView checkinForRowAtIndexPath:(NSIndexPath *)indexPath{
    
	switch (indexPath.row) {
		case 0:{
			
			NSString *cellId = [NSString stringWithFormat:@"checkin:%@", accountId];
			
			UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
			
			if(cell == nil){
				
				cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
				
				NSDictionary *row = [[[[OVDatabase sharedInstance] executeQuery:@"select * from Account where Id = ?", accountId] readToEnd] objectAtIndex:0];
				
				cell.textLabel.text = [row objectForKey:@"Name"];
				cell.detailTextLabel.text = [[NSDate date] format:@"HH:mm"];
				
				[cell addSubview:[UILabel hiddenLabelForText:planId withTag:tagForSFEventId]];
				[cell addSubview:[UILabel hiddenLabelForText:accountId withTag:tagForSFAccountId]];
				
				cell.tag = tagForCellCheckedIn;
			}
			
			[tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionTop];
			
			return cell;
			
		}break;
			
		case 1:{
			
			NSString *cellId = [NSString stringWithFormat:@"checkout:%@", accountId];
			
			UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
			
			if(cell == nil){
				
				cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
				
				cell.textLabel.text = @"Checkout";
				cell.backgroundColor = [UIColor whiteColor];
				cell.accessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
				
				cell.tag = tagForCellCheckOut;
			}
			
			return cell;
			
		}break;
	}
	
    return nil;
}

-(UITableViewCell *)tableView:(UITableView *)tableView menuForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *data = [self.todayPlan objectAtIndex:indexPath.row];
    NSString *cellId = [NSString stringWithFormat:@"menu:%@", [data objectForKey:@"Id"]];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if(cell == nil){
        
        cell.tag = tagForCellMenu;
    }
    
    return cell;
}

-(UITableViewCell *)tableView:(UITableView *)tableView sfForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *cellId = [NSString stringWithFormat:@"sf:%d", indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if(cell == nil){
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
        
        cell.textLabel.text = @"Sync";
        cell.tag = tagForCellSF;
        
    }
	
	FMResultSet *result = [[OVDatabase sharedInstance] executeQuery:@"select count(*) from Upload where syncTime is null"];
	[result next];
	
	int leftUnsync = [result intForColumnIndex:0];
	
	[self updateUploadStatus:leftUnsync];
	
	[UIApplication sharedApplication].applicationIconBadgeNumber = leftUnsync;
	
	cell.detailTextLabel.text = [[AppDelegate sharedInstance].user objectForKey:@"lastSyncDate"];
    
	
	[result close];
	
    return cell;
    
}



@end
