//
//  OVPlanViewController+UITableViewHandler.m
//  OVCRM
//
//  Created by Sopon Srisummasheep on 7/22/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import "OVPlanViewController.h"
#import "OVDatabase.h"

#define OV_PLAN_ACCOUNT_SECTION_HEADER_HEIGHT 44

@implementation OVPlanViewController (UITableViewHandler)

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
	return 3;
}

-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
	switch (section) {
		case 2: return OV_PLAN_ACCOUNT_SECTION_HEADER_HEIGHT;
			
		default:return 22;
	}
}

-(CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
	switch (section) {
		case 2: return 400;
			
		default:return 0;
	}
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
	
	switch(section){
			
		case 2:{
			
			self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(44, 350, 300, OV_PLAN_ACCOUNT_SECTION_HEADER_HEIGHT)];
			
			[self.searchBar setTranslucent:YES];
			self.searchBar.placeholder = @"Account...";
			self.searchBar.delegate = self;
			self.searchBar.text = previousSearchText;
			
			if ([[[self.searchBar subviews] objectAtIndex:0] isKindOfClass:[UIImageView class]]){
				[[[self.searchBar subviews] objectAtIndex:0] removeFromSuperview];
			}
			
			UIView *custom = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, OV_PLAN_ACCOUNT_SECTION_HEADER_HEIGHT)];
			custom.backgroundColor = [UIColor clearColor];
			custom.opaque = NO;
			
			// not add to custom to prevent control lost focus when table is reloadData
			[self.tableView addSubview:self.searchBar];
			
			return custom;
		};
			
		default: return nil;
	}
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
	switch (section) {
		case 0: return @"Visit Detail";
			
		case 1: return @"Description Information";
			
		case 2: return @" ";
			
		default:return nil;
	}
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	
	switch (section) {
		case 0: return 3;
			
		case 1: return 1;
			
		case 2: return filtered.count;
			
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
	
	NSDictionary *data = [filtered objectAtIndex:indexPath.row];
	
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
	
	switch (indexPath.section) {
		case 0:
			if(indexPath.row == 2){
				[self tableView:self.tableView showPickerViewAtIndexPath:indexPath];
			}
			else{
				[self tableView:self.tableView showDatePickerAtIndexPath:indexPath];
			}
			break;
			
		case 2:
			[tableView.indexPathsForSelectedRows enumerateObjectsUsingBlock:^(NSIndexPath *each, NSUInteger index, BOOL *stop){
				[tableView deselectRowAtIndexPath:each animated:YES];
			}];
			break;
	}
	
	return indexPath;
}

- (NSIndexPath *)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	[self validate];
	
	if(indexPath.section == 2){
		
		[self performSelectorOnMainThread:@selector(dismissKeyboard:) withObject:self.tableView waitUntilDone:YES];
		[self.tableView scrollsToTop];
		
	}
	
	return indexPath;
}

@end
