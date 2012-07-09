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
        
        
        UILabel *labelForAccountId = [UILabel new];
        labelForAccountId.tag = tagForSFAccountId;
        labelForAccountId.text = [data objectForKey:@"WhatId"];
        labelForAccountId.hidden = YES;
        
        UILabel *labelForEventId = [UILabel new];
        labelForEventId.tag = tagForSFEventId;
        labelForEventId.text = [data objectForKey:@"Id"];
        labelForEventId.hidden = YES;
        
        [cell addSubview:labelForAccountId];
        [cell addSubview:labelForEventId];
    }
    
    return cell;
}

-(UITableViewCell *)tableView:(UITableView *)tableView checkinForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *data = [self.todayPlan objectAtIndex:indexPath.row];
    NSString *cellId = [NSString stringWithFormat:@"checkin:%@", [data objectForKey:@"Id"]];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if(cell == nil){
        
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
        cell.detailTextLabel.text = @"last sync date";
        cell.accessoryView = [UIButton buttonWithType:UIButtonTypeInfoDark];
        cell.tag = tagForCellSF;
        
    }
    
    return cell;
    
}

@end
