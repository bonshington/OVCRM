//
//  OVCallCardController+UITableViewHandler.m
//  OVCRM
//
//  Created by Apple on 20/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OVCallCardController.h"

#define CC_TAG_PRODUCT	10

@implementation OVCallCardController (UITableViewHandler)

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	
	return self.product.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	
	NSDictionary *prod = [self.product objectAtIndex:indexPath.row];
	
	NSString *prodId = [prod objectForKey:@"Id"];
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:prodId];
	
	if(cell == nil){
		
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:prodId];
		
		CGFloat width = [cell viewWithTag:CC_TAG_PRODUCT].frame.size.width;
		
		cell.textLabel.frame = CGRectMake(cell.textLabel.frame.origin.x, 
										  cell.textLabel.frame.origin.y, 
										  width, 
										  cell.textLabel.frame.size.height);
		cell.textLabel.text = [prod objectForKey:@"product_Category"];
		
		cell.detailTextLabel.frame = CGRectMake(cell.detailTextLabel.frame.origin.x, 
												cell.detailTextLabel.frame.origin.y, 
												width, 
												cell.detailTextLabel.frame.size.height);
		cell.detailTextLabel.text = [prod objectForKey:@"product_Code"];
	}
	
	return cell;
}

@end
