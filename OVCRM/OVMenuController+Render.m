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
			
			NSString *cellId = [NSString stringWithFormat:@"checkin:%@", self.checkedAccountId];
			
			UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
			
			if(cell == nil){
				
				cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
				
				NSDictionary *row = [[[[OVDatabase sharedInstance] executeQuery:@"select * from Account where Id = ?", self.checkedAccountId] readToEnd] objectAtIndex:0];
				
				cell.textLabel.text = [row objectForKey:@"Name"];
				cell.detailTextLabel.text = [[NSDate date] format:@"HH:mm"];
				
				[cell addSubview:[UILabel hiddenLabelForText:self.checkinEventId withTag:tagForSFEventId]];
				[cell addSubview:[UILabel hiddenLabelForText:self.checkedAccountId withTag:tagForSFAccountId]];
				
				cell.tag = tagForCellCheckedIn;
			}
			
			[tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionTop];
			
			return cell;
			
		}break;
			
		case 1:{
			
			NSString *cellId = [NSString stringWithFormat:@"checkout:%@", self.checkedAccountId];
			
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
