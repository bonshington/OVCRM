//
//  OVPlanViewController+UITableViewHandler.m
//  OVCRM
//
//  Created by Sopon Srisummasheep on 7/22/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import "OVPlanViewController.h"
#import "OVDatabase.h"

@implementation OVPlanViewController (UITableViewHandler)

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
	return 3;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
	switch (section) {
		case 0: return @"Visit Detail";
			
		case 1: return @"Description Information";
			
		case 2: return @"Account";
			
		default:return nil;
	}
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	
	switch (section) {
		case 0: return 3;
			
		case 1: return 1;
			
		case 2: return self.account.count;
			
		default:return 0;
	}
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	
	switch (indexPath.section) {

		case 0:return [self tableView:tableView calendarAtIndexPath:indexPath];
			
		case 1:return [self tableView:tableView descriptionAtIndexPath:indexPath];	
		
		case 2:return [self tableView:tableView accountAtIndexPath:indexPath];
			
			
		default: return nil;
	}
	
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	
	switch (indexPath.section) {
		case 1: return 150;
			
		default: return 44;
	}
}


#pragma mark - render in each section

-(UITableViewCell *) tableView:(UITableView *)tableView calendarAtIndexPath:(NSIndexPath *)indexPath{
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[indexPath toString]];
	
	if(cell == nil){
		
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:[indexPath toString]];
		
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		
		switch (indexPath.row) {
			case 0: 
				cell.textLabel.text = @"Start"; 
				cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
				cell.tag = tagForCellStartDate;
				break;
				
			case 1: 
				cell.textLabel.text = @"End"; 
				cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
				cell.tag = tagForCellEndDate;
				break;
				
			case 2: 
				cell.textLabel.text = @"Visit Type"; 
				cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
				break;
		}
		
		cell.textLabel.backgroundColor = [UIColor clearColor];
		cell.detailTextLabel.backgroundColor = [UIColor clearColor];
	}
	
	return cell;
}

-(UITableViewCell *) tableView:(UITableView *)tableView descriptionAtIndexPath:(NSIndexPath *)indexPath{
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[indexPath toString]];
	
	if(cell == nil){
		
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[indexPath toString]];
		cell.selectionStyle = UITableViewCellSelectionStyleNone;
		
		self.textArea.frame = CGRectMake(0, 0, 617, 150);
		self.textArea.backgroundColor = [UIColor clearColor];
		
		[cell.contentView addSubview:self.textArea];
	}
	
	return cell;
}

-(UITableViewCell *) tableView:(UITableView *)tableView accountAtIndexPath:(NSIndexPath *)indexPath{
	
	NSDictionary *data = [self.account objectAtIndex:indexPath.row];
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[data objectForKey:@"Id"]];
	
	if(cell == nil){
		
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:[data objectForKey:@"Id"]];
		
		cell.textLabel.text = [data objectForKey:@"Name"];
		cell.detailTextLabel.text = [NSString stringWithFormat:@"%@, %@", [data objectForKey:@"Amphur__c"], [data objectForKey:@"Addr1__c"]];
		
		cell.selectionStyle = UITableViewCellSelectionStyleBlue;
		
		cell.textLabel.backgroundColor = [UIColor clearColor];
		cell.detailTextLabel.backgroundColor = [UIColor clearColor];
	}
	
	return cell;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	
	// description area
	if(indexPath.section == 1){
		return nil;
	}
	
	if(indexPath.section == 0){
		
		switch (indexPath.row) {
			case 0:
			case 1:
				[self tableView:tableView showDatePickerAtIndexPath:indexPath]; 
				break;
				
			case 2:
				[self tableView:tableView showPickerViewAtIndexPath:indexPath]; 
				break;
		}
		
	}
	
	if(tableView.indexPathsForSelectedRows != nil){
		
		[tableView.indexPathsForSelectedRows enumerateObjectsUsingBlock:^(NSIndexPath *each, NSUInteger index, BOOL *stop){
			if(each.section == indexPath.section)
				[tableView deselectRowAtIndexPath:each animated:YES];
		}];
	}
	
	return indexPath;
}

- (NSIndexPath *)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	[self validate];
	
	return indexPath;
}

@end
