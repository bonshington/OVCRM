//
//  OVCallCardController+UITableViewHandler.m
//  OVCRM
//
//  Created by Apple on 20/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OVCallCardController.h"


@implementation OVCallCardController (UITableViewHandler)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	
	NSDictionary *prod = [self.filtered objectAtIndex:indexPath.row];
	
	NSString *prodId = [prod objectForKey:@"Id"];
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:prodId];
	
	if(cell == nil){
		
		if(tableView == self.historyTable){
			return [historyManager cellForId:prodId];
		}
		else {
			NSDictionary *_data = [self.data objectForKey:prodId];
			
			cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:prodId];
			
			cell.textLabel.text = [prod objectForKey:@"product_Category"];
			cell.detailTextLabel.text = [prod objectForKey:@"product_Code"];
			
			cell.selectionStyle = UITableViewCellSelectionStyleNone;
			
			[self tableViewCell:cell renderInputWith:_data];
			
			[self tableViewCell:cell renderLabelWith:[self.indexing objectForKey:prodId]];
			
		}
	}
	
	return cell;
}
	
	

-(void)tableViewCell:(UITableViewCell *)cell renderInputWith:(NSDictionary *)_data{
	
	NSString *text1 = nil;
	NSString *text2 = nil;
	
	
	if(_data != nil && [_data objectForKey:@"Quantity_Remain__c"] != nil)
		text1 = [_data objectForKey:@"Quantity_Remain__c"];
		
	if(_data != nil && [_data objectForKey:@"In_Stock__c"] != nil)
		text2 = [_data objectForKey:@"In_Stock__c"];
	
	
	[cell addSubview:[UITextField newWithCGRect:CGRectMake(CC_UI_OFFSET_ON_SHELF, 7, 80, 30) 
											tag:tagForOnShelf 
										   text:text1 
									  respondTo:self 
									   selector:@selector(change:)]];
	
	[cell addSubview:[UITextField newWithCGRect:CGRectMake(CC_UI_OFFSET_IN_STORE, 7, 80, 30) 
											tag:tagForInStock 
										   text:text2 
									  respondTo:self 
									   selector:@selector(change:)]];
}

-(void)tableViewCell:(UITableViewCell *)cell renderLabelWith:(NSDictionary *)_data{
	
	[cell addSubview:[UILabel labelWithRect:CGRectMake(300, 0, 80, 44) 
										tag:0 
									 number:[_data objectForKey:@"weight"]]];
	
	[cell addSubview:[UILabel labelWithRect:CGRectMake(390, 0, 80, 44) 
										tag:0 
									 number:[_data objectForKey:@"packaging"]]];
	
	[cell addSubview:[UILabel labelWithRect:CGRectMake(480, 0, 80, 44) 
										tag:0 
									 number:[_data objectForKey:@"packSize"]]];
	
	[cell addSubview:[UILabel labelWithRect:CGRectMake(570, 0, 80, 44) 
										tag:0 
									 number:[_data objectForKey:@"List_Price__c"]]];
}

@end
