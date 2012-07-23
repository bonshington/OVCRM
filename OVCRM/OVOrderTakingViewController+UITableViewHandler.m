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

	if(self.selected.count == 0)
		return 1;
	else 
		return 2;
}

-(NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
	if(tableView == self.historyView){
		return @" ";
	}
	else{
		switch (section) {
			case 0: 
				if(self.selected.count == 0)
					return @"Product";
				else 
					return @"Taking";
				
			case 1: return @"Product";
				
			default:return nil;
		}
	}

}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	switch (section) {
		case 0: 
			if(self.selected.count == 0)
				return self.filtered.count;
			else 
				return self.selected.count;
			
		case 1: return self.filtered.count;
			
		default:return 0;
	}
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	
	NSDictionary *_data = nil;
	
	switch (indexPath.section) {
		case 0: 
			if(self.selected.count == 0)
				_data = [self.filtered objectAtIndex:indexPath.row];
			else 
				_data = [self.selected objectAtIndex:indexPath.row];
			
			break;
			
		case 1: _data = [self.filtered objectAtIndex:indexPath.row];
			break;
			
		default:return nil;
	}
	
	
	NSString *cellId = [_data objectForKey:@"prod_db_id__c"];
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
	
	if(cell == nil){
		
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
		
		if(tableView == self.historyView){
			[self tableViewCell:cell historyForIndexPath:indexPath forData:_data];
		}
		else {
			cell.textLabel.text = [_data objectForKey:@"product_Category"];
			cell.detailTextLabel.text = [_data objectForKey:@"product_Code"];
			
			
			[self tableViewCell:cell productForData:_data];
			
			[self tableViewCell:cell callcardForIndexPath:indexPath];
		}
		
	}
	
	return cell;
}

-(UITableViewCell *) tableViewCell:(UITableViewCell *)cell callcardForIndexPath:(NSIndexPath *)indexPath{
	
	NSDictionary *_callcard = [callcard objectForKey:cell.reuseIdentifier];
	
	NSString *text1 = [_callcard objectForKey:@"Quantity_Remain__c"];
	NSString *text2 = [_callcard objectForKey:@"In_Stock__c"];
	
	if(text1 == nil) text1 = @"-";
	if(text2 == nil) text2 = @"-";
		
	
	[cell addSubview:[UILabel labelWithRect:CGRectMake(700, 0, 125, 44) 
										tag:0 
									   text:[NSString stringWithFormat:@"%@/%@", text1, text2]]];
	
	return cell;
}

-(UITableViewCell *) tableViewCell:(UITableViewCell *)cell productForData:(NSDictionary *)_data{
	
	[cell addSubview:[UILabel labelWithRect:CGRectMake(295, 0, 85, 44) 
										tag:0 
									 number:[_data objectForKey:@"weight"]]];
	
	[cell addSubview:[UILabel labelWithRect:CGRectMake(385, 0, 85, 44) 
										tag:0 
									 number:[_data objectForKey:@"packaging"]]];
	
	[cell addSubview:[UILabel labelWithRect:CGRectMake(475, 0, 85, 44) 
										tag:0 
									 number:[_data objectForKey:@"packSize"]]];
	
	
	
	return cell;
}

-(UITableViewCell *) tableViewCell:(UITableViewCell *)cell historyForIndexPath:(NSIndexPath *)indexPath forData:(NSDictionary *)_data{
	
	[cell addSubview:[UILabel labelWithRect:CGRectMake(565, 0, 85, 44) 
										tag:0 
									 number:[_data objectForKey:@"sales price??"]]];
	
	return cell;
}

@end
