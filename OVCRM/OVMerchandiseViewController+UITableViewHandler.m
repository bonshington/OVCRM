//
//  OVMerchandiseViewController+UITableViewHandler.m
//  OVCRM
//
//  Created by Sopon Srisummasheep on 7/21/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import "OVMerchandiseViewController.h"


#define MC_ON_SHELF_OFFSET 810
#define MC_FACING_OFFSET 920


@implementation OVMerchandiseViewController (UITableViewHandler)


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	
	NSDictionary *prod = [self.filtered objectAtIndex:indexPath.row];
	
	NSString *prodId = [prod objectForKey:@"Id"];
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:prodId];
	
	if(cell == nil){
		
		NSDictionary *_data = [self.data objectForKey:prodId];
		
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:prodId];
		
		cell.textLabel.text = [prod objectForKey:@"product_Category"];
		cell.detailTextLabel.text = [prod objectForKey:@"product_Code"];
		
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		
		[self tableViewCell:cell renderInputWith:_data];
		
		[self tableViewCell:cell renderLabelWith:_data];
	}
	
	return cell;
}

-(void)tableViewCell:(UITableViewCell *)cell renderInputWith:(NSDictionary *)_data{
	
	NSString *text1 = nil;
	NSString *text2 = nil;
	
	if(_data != nil && [_data objectForKey:@"On_Shelf_Price__c"] != nil)
		text1 = [NSString stringWithFormat:@"%@", [_data objectForKey:@"On_Shelf_Price__c"]];
	
	
	
	if(_data != nil && [_data objectForKey:@"Shelf_Share__c"] != nil)
		text2 = [NSString stringWithFormat:@"%@", [_data objectForKey:@"Shelf_Share__c"]];
	
	[cell addSubview:[UITextField newWithCGRect:CGRectMake(MC_ON_SHELF_OFFSET, 7, 80, 30) 
											tag:tagForOnShelfPrice 
										   text:text1 
									  respondTo:self 
									   selector:@selector(change:)]];
	
	[cell addSubview:[UITextField newWithCGRect:CGRectMake(MC_FACING_OFFSET, 7, 80, 30) 
											tag:tagForFacing 
										   text:text2 
									  respondTo:self 
									   selector:@selector(change:)]];
}

-(void)tableViewCell:(UITableViewCell *)cell renderLabelWith:(NSDictionary *)_data{
	
	NSDictionary *prod = [self.indexing objectForKey:cell.reuseIdentifier];
	
	[cell addSubview:[UILabel labelWithRect:CGRectMake(550, 7, 80, 30) tag:0 number:[prod objectForKey:@"packSize"]]];

}

@end
