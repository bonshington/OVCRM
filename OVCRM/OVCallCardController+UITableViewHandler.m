//
//  OVCallCardController+UITableViewHandler.m
//  OVCRM
//
//  Created by Apple on 20/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OVCallCardController.h"




@implementation OVCallCardController (UITableViewHandler)

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	
	return self.filtered.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	
	NSDictionary *prod = [self.filtered objectAtIndex:indexPath.row];
	
	NSString *prodId = [prod objectForKey:@"Id"];
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:prodId];
	
	if(cell == nil){
		
		NSDictionary *_data = [self.callcard_data objectForKey:prodId];
		NSDictionary *_history = [self.history objectForKey:prodId];
		
		NSString *_onshelf = nil;
		NSString *_instock = nil;
		
		
		if(_data != nil && [_data objectForKey:@"OnShelf"] != nil)
			_onshelf = [_data objectForKey:@"OnShelf"];
		
		if(_data != nil && [_data objectForKey:@"InStock"])
			_instock = [_data objectForKey:@"InStock"];
		
		
		
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:prodId];
		
		cell.textLabel.text = [prod objectForKey:@"product_Category"];
		cell.detailTextLabel.text = [prod objectForKey:@"product_Code"];
		
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		
		[cell addSubview:[UITextField newWithCGRect:CGRectMake(CC_UI_OFFSET_ON_SHELF, 7, 80, 30) 
												tag:CC_TAG_ON_SHELF 
											   text:_onshelf 
										  respondTo:self 
										   selector:@selector(save:)]];
		
		[cell addSubview:[UITextField newWithCGRect:CGRectMake(CC_UI_OFFSET_IN_STORE, 7, 80, 30) 
												tag:CC_TAG_IN_STOCK 
											   text:_instock 
										  respondTo:self 
										   selector:@selector(save:)]];
		
		if(_history != nil){
			
			for(int i = 0; i < 4; i++){
				[UILabel labelWithRect:CGRectMake(CC_UI_OFFSET_INV + (i*CC_UI_SPACE_INV), 7, 100, 30) 
								   tag:CC_TAG_INV + i 
								  text:[_history objectForKey:[NSString stringWithFormat:@"inv%d", i]]];
			}
					
		}
	}
	
	return cell;
}

@end
