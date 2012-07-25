//
//  OVOrderTakingViewController+UITableViewHandler.m
//  OVCRM
//
//  Created by Apple on 23/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OVOrderTakingViewController.h"

@implementation OVOrderTakingViewController (UITableViewHandler)


-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	return self.filtered.count;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	
	NSDictionary *_data = [self.filtered objectAtIndex:indexPath.row];
	
	NSString *prodId = [_data objectForKey:@"Id"];
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:prodId];
	
	if(cell == nil){
		
		if(tableView == self.historyTable){
			
			cell = [historyManager cellForId:prodId];
			
		}
		else {
			cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:prodId];
			
			cell.textLabel.text = [_data objectForKey:@"name"];
			cell.detailTextLabel.text = [_data objectForKey:@"code"];
			
			cell.textLabel.backgroundColor = [UIColor clearColor];
			cell.detailTextLabel.backgroundColor = [UIColor clearColor];
			
			
			[self tableViewCell:cell productForData:_data];
			
			[self tableViewCell:cell callcardForIndexPath:indexPath];
			
			UITextField *input = [UITextField newWithCGRect:CGRectMake(self.tableView.frame.size.width - 93, 7, 80, 30)
														tag:0 
													   text:@"" 
												  respondTo:self 
												   selector:@selector(change:)];
			
			[cell addSubview:input];
			
			if([promotionCriteria objectForKey:prodId] != nil){
				cell.contentView.backgroundColor = [UIColor colorWithRed:1 green:1 blue:0.85 alpha:0.8];
				
				//input.placeholder = @"condition";
			}
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
									   text:[NSString stringWithFormat:@"%@ / %@", text1, text2]]];
	
	return cell;
}

-(UITableViewCell *) tableViewCell:(UITableViewCell *)cell productForData:(NSDictionary *)_data{
	
	[cell addSubview:[UILabel labelWithRect:CGRectMake(300, 0, 80, 44) 
										tag:0 
									 number:[_data objectForKey:@"weight"]]];
	
	[cell addSubview:[UILabel labelWithRect:CGRectMake(390, 0, 80, 44) 
										tag:0 
									 number:[_data objectForKey:@"packaging"]]];
	
	[cell addSubview:[UILabel labelWithRect:CGRectMake(480, 0, 80, 44) 
										tag:0 
									 number:[_data objectForKey:@"packSize"]]];
	
	
	
	return cell;
}

@end
