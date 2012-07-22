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
		
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:prodId];
		
		cell.textLabel.text = [prod objectForKey:@"product_Category"];
		cell.textLabel.backgroundColor = [UIColor clearColor];
		
		cell.detailTextLabel.text = [prod objectForKey:@"product_Code"];
		cell.detailTextLabel.backgroundColor = [UIColor clearColor];
		
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		
		[self tableViewCell:cell renderInputWith:_data];
		
		[self tableViewCell:cell renderLabelWith:_data];
		
	}
	
	return cell;
}

-(void)tableViewCell:(UITableViewCell *)cell renderInputWith:(NSDictionary *)_data{
	
	NSString *text1 = nil;
	NSString *text2 = nil;
	
	if(_data != nil && [_data objectForKey:@"Return_Quantity__c"] != nil)
		text1 = [NSString stringWithFormat:@"%@", [_data objectForKey:@"Return_Quantity__c"]];
	
	
	
	if(_data != nil && [_data objectForKey:@"Reason_for_Return__c"] != nil)
		text2 = [NSString stringWithFormat:@"%@", [_data objectForKey:@"Reason_for_Return__c"]];
	
	UITextField *input = [UITextField newWithCGRect:CGRectMake(780, 7, 80, 30) 
												tag:tagForReturnQty 
											   text:text1 
										  respondTo:self 
										   selector:@selector(change:)];
	input.delegate = self;
	[cell addSubview:input];
	
	
	
	UIButton *accessory = [UIButton buttonWithType:UIButtonTypeContactAdd];
	[accessory addTarget:self action:@selector(openPicker:) forControlEvents:UIControlEventTouchUpInside];
	[cell setAccessoryView:accessory];
	
}

-(void)tableViewCell:(UITableViewCell *)cell renderLabelWith:(NSDictionary *)_data{
	
	NSDictionary *prod = [self.indexing objectForKey:cell.reuseIdentifier];
	
	[cell addSubview:[UILabel labelWithRect:CGRectMake(390, 7, 75, 30) tag:0 number:[prod objectForKey:@"weight"]]];
	[cell addSubview:[UILabel labelWithRect:CGRectMake(480, 7, 75, 30) tag:0 number:[prod objectForKey:@"packaging"]]];
	[cell addSubview:[UILabel labelWithRect:CGRectMake(570, 7, 75, 30) tag:0 number:[prod objectForKey:@"packSize"]]];
	[cell addSubview:[UILabel labelWithRect:CGRectMake(660, 7, 75, 30) tag:0 number:[prod objectForKey:@"List_Price__c"]]];
	
		
	NSString *reason = [_data objectForKey:@"Reason_for_Return__c"];
	UILabel *label = [UILabel labelWithRect:CGRectMake(870, 7, 110, 30) tag:tagForReturnReason text:reason];
	
	label.backgroundColor = [UIColor clearColor];
	label.textAlignment = UITextAlignmentRight;
	label.font = [UIFont fontWithName:label.font.fontName size:14];
	label.hidden = (reason == nil) ||reason.length == 0;
	
	[cell addSubview:label];
}

@end
