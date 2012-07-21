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
		
		NSString *text1 = nil;
		NSString *text2 = nil;
		
		
		if(_data != nil && [_data objectForKey:@"On_Shelf_Price__c"] != nil)
			text1 = [_data objectForKey:@"On_Shelf_Price__c"];
		
		
		
		if(_data != nil && [_data objectForKey:@"Shelf_Share__c"] != nil)
			text2 = [_data objectForKey:@"Shelf_Share__c"];
		
		
		
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:prodId];
		
		cell.textLabel.text = [prod objectForKey:@"product_Category"];
		cell.detailTextLabel.text = [prod objectForKey:@"product_Code"];
		
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		
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
		
		// set packsize, abf price, onshelf price, facing
		
		
	}
	
	return cell;
}

@end
