//
//  OVGoodReturnViewController+UITableViewHandler.m
//  OVCRM
//
//  Created by Sopon Srisummasheep on 7/22/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import "OVGoodReturnViewController.h"

@implementation OVGoodReturnViewController (UITableViewHandler)

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	
	NSDictionary *prod = [self.filtered objectAtIndex:indexPath.row];
	
	NSString *prodId = [prod objectForKey:@"Id"];
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:prodId];
	
	if(cell == nil){
		
		NSDictionary *_data = [self.data objectForKey:prodId];
		
		NSString *text1 = nil;
		NSString *text2 = nil;
		
		
		if(_data != nil && [_data objectForKey:@"Return_Quantity__c"] != nil)
			text1 = [NSString stringWithFormat:@"%@", [_data objectForKey:@"Return_Quantity__c"]];
		
		
		
		if(_data != nil && [_data objectForKey:@"Reason_for_Return__c"] != nil)
			text2 = [NSString stringWithFormat:@"%@", [_data objectForKey:@"Reason_for_Return__c"]];
		
		
		
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:prodId];
		
		cell.textLabel.text = [prod objectForKey:@"product_Category"];
		cell.detailTextLabel.text = [prod objectForKey:@"product_Code"];
		
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		
		
		
		
		[cell addSubview:[UITextField newWithCGRect:CGRectMake(0, 7, 80, 30) 
												tag:tagForReturnQty 
											   text:text1 
										  respondTo:self 
										   selector:@selector(change:)]];
		
		[cell addSubview:[UITextField newWithCGRect:CGRectMake(0, 7, 80, 30) 
												tag:tafForReturnReason 
											   text:text2 
										  respondTo:self 
										   selector:@selector(change:)]];
		
		// set packsize, abf price, onshelf price, facing
		
		
	}
	
	return cell;
}

@end
