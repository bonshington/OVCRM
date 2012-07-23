//
//  OVOrderTakingViewController+UITableViewHandler.m
//  OVCRM
//
//  Created by Apple on 23/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OVOrderTakingViewController.h"

@implementation OVOrderTakingViewController (UITableViewHandler)

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

	return 2;
}

-(NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
	switch (section) {
		case 0: return @"Selected";
			
		case 1: return @"Availabel";
			
		default: return nil;
	}
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	switch (section) {
		case 0: return self.selected.count;
			
		case 1: return self.filtered.count;
			
		default: return 0;
	}
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	
	NSDictionary *_data = [self.product objectAtIndex:indexPath.row];
	
	NSString *cellId = [_data objectForKey:@"prod_db_id__c"];
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
	
	if(cell == nil){
		
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
		
		cell.textLabel.text = [_data objectForKey:@""];
		cell.detailTextLabel.text = [_data objectForKey:@""];
		
		[cell addSubview:[UILabel labelWithRect:CGRectMake(0, 0, 0, 0) 
											tag:0 
										 number:0]];
	}
	
	return cell;
}

-(UITableViewCell *) tableView:(UITableView *)tableView selectRowAtIndexPath:(NSIndexPath *)indexPath{
	
}

-(UITableViewCell *) tableView:(UITableView *)tableView productRowAtIndexPath:(NSIndexPath *)indexPath{
	
}

@end
