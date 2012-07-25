//
//  OVOrderSummaryManager.m
//  OVCRM
//
//  Created by Apple on 25/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OVOrderSummaryManager.h"
#import "AppDelegate.h"

@implementation OVOrderSummaryManager

@synthesize view;


-(id) initWithTableView:(UITableView *)tableView{
	
	self = [super init];
	
	if(self != nil){
		
		_container = tableView;
		
		_tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) 
												  style:UITableViewStylePlain];
		_tableView.hidden = YES;
		
		_tableView.dataSource = self;
		_tableView.delegate = self;
		
		[_container addSubview:_tableView];
	}
	
	return self;
}

-(void)showWithData:(NSDictionary *)data{
	
	if(!view.hidden)
		return;
	
	_data = data;
	
	[_tableView reloadData];
	
	_tableView.hidden = NO;

	_tableView.frame = CGRectMake(-1 * UITableView_SummaryView_Width
							, 0
							, UITableView_SummaryView_Width
							, _container.contentSize.height);
	
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration: 0.25];
	[UIView setAnimationCurve: UIViewAnimationCurveEaseIn];
	
	_tableView.frame = CGRectMake(0
							, 0
							, UITableView_SummaryView_Width
							, _container.contentSize.height);
	
	
	
	[UIView commitAnimations];
}

-(void)hide:(id)sender{
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDuration: 0.25];
	[UIView setAnimationCurve: UIViewAnimationCurveEaseOut];
	[UIView setAnimationDidStopSelector:@selector(didHide:)];
	
	_tableView.frame = CGRectMake(-1 * UITableView_SummaryView_Width
							, 0
							, UITableView_SummaryView_Width
							, _container.contentSize.height);
	
	
	[UIView commitAnimations];
}

-(void) didHide:(id)sender{
	_tableView.hidden = YES;
}


#pragma mark - UITableViewDataSource

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	return 2;
}

-(NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
	switch (section) {
		case 0: return @"Total";
		case 1: return @"Order";
			
		default:return nil;
	}
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	
	UITableViewCell *cell = nil;
	
	switch (indexPath.section) {
		case 0:{
			NSString *cellId = [indexPath toString];
			
			cell = [tableView dequeueReusableCellWithIdentifier:cellId];
			
			if(cell == nil){ // render total
				
				cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellId];
				
				
			}
		
		}break;
			
		case 1:{
			NSString *prodId = [_data keyAtIndex:indexPath.row];
			
			cell = [tableView dequeueReusableCellWithIdentifier:prodId];
			
			if(cell == nil){ // render products
				
				cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:prodId];
				
				cell.textLabel.text = @""; // prod name
				cell.detailTextLabel.text = @""; //amount
			}
			
		}break;
	}
	
	return cell;
}

@end
