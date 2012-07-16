//
//  OVMenuController+Render.m
//  OVCRM
//
//  Created by Apple on 06/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OVMenuController.h"
#import "RKJSONParserJSONKit.h"
#import "NSDictionary+SFSchema.h"


#import "Constant.h"

@implementation OVMenuController (Render)


-(UITableViewCell *)tableView:(UITableView *)tableView planForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *data = [self.todayPlan objectAtIndex:indexPath.row];
    NSString *cellId = [NSString stringWithFormat:@"plan:%@", [data objectForKey:@"Id"]];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if(cell == nil){
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
        
        cell.textLabel.text = [data objectForKey:@"What"];
        cell.detailTextLabel.text = [data objectForKey:@"time"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.tag = tagForCellPlanVisit;
        
        [cell addSubview:[UILabel hiddenLabelForText:[data objectForKey:@"WhatId"] withTag:tagForSFAccountId]];
        [cell addSubview:[UILabel hiddenLabelForText:[data objectForKey:@"Id"] withTag:tagForSFEventId]];
    }
    
    return cell;
}

-(UITableViewCell *)tableView:(UITableView *)tableView checkinForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *cellId = [NSString stringWithFormat:@"checkin:%@", self.checkedAccountId];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if(cell == nil){
		
		OVDatabase *db = [OVDatabase sharedInstance];
		
		NSDictionary *row = [[[db executeQuery:@"select * from Account where Id = ?", self.checkedAccountId] readToEnd] objectAtIndex:0];
		
		cell.textLabel.text = [row objectForKey:@"Name"];
		cell.detailTextLabel.text = [[NSDate date] format:@"HH:mm"];
		
		[cell addSubview:[UILabel hiddenLabelForText:self.checkinEventId withTag:tagForSFEventId]];
		[cell addSubview:[UILabel hiddenLabelForText:self.checkedAccountId withTag:tagForSFAccountId]];
		
        cell.tag = tagForCellCheckedIn;
    }
    
    return cell;
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
