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

@implementation OVMenuController (Render)


-(UITableViewCell *)tableView:(UITableView *)tableView planForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *cellId = [NSString stringWithFormat:@"plan:%@", [[self.todayPlan objectAtIndex:indexPath.row] objectForKey:@"Id"]];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if(cell == nil){
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
        
        NSDictionary *data = [self.todayPlan objectAtIndex:indexPath.row];
                
        //id test = [data extractObjectForKey:@"What" withProperty:@"Name"];
        
        cell.textLabel.text = [data extractObjectForKey:@"What" withProperty:@"Name"];
        cell.detailTextLabel.text = [data objectForKey:@"time"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        //[tableView accessoryButtonTappedForRowWithIndexPath]
    }
    
    return cell;
}

-(UITableViewCell *)tableView:(UITableView *)tableView checkinForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *cellId = [NSString stringWithFormat:@"checkin:%@", [[self.todayPlan objectAtIndex:indexPath.row] objectForKey:@"Id"]];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if(cell == nil){
        
    }
    
    return cell;
}

-(UITableViewCell *)tableView:(UITableView *)tableView accountForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *cellId = [NSString stringWithFormat:@"account:%@", [[self.todayPlan objectAtIndex:indexPath.row] objectForKey:@"Id"]];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    if(cell == nil){
        
    }
    
    return cell;
}

@end
