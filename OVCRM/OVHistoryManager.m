//
//  OVHistoryManager.m
//  OVCRM
//
//  Created by Apple on 24/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OVHistoryManager.h"
#import "SFProduct.h"

@implementation OVHistoryManager

@synthesize delegate;

-(id) initWithTableView:(UITableView *)tableView 
				 column:(UIView *)column 
			  container:(UITableView *)container{
	
	self = [super init];
	
	if(self != nil){
		
		_tableView = tableView;
		_column = column;
		_container = container;
		
		//bind
		_tableView.scrollEnabled = NO;
		_tableView.hidden = YES;
		
		[_container addSubview:_tableView];
	
		
		// load data;
		NSString *accountId = [[AppDelegate sharedInstance].checkin objectForKey:@"AccountId"];
		_data = [[SFProduct sellingForAccount:accountId] dictionaryFromObjectForKey:@"Id"];
	}
	
	return self;
}

-(void) show:(id)sender{
	
	_tableView.hidden = NO;
	_column.hidden = NO;
	//[_tableView reloadData];
	
	CGFloat containerWidth = _container.frame.size.width;
	
	_tableView.frame = CGRectMake(containerWidth - 100
								  , 0
								  , UITableView_HistoryView_Width
								  , _container.contentSize.height);
	
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration: 0.25];
	[UIView setAnimationCurve: UIViewAnimationCurveEaseIn];
	
	_tableView.frame = CGRectMake(_container.frame.size.width - UITableView_HistoryView_Width
								  , 0
								  , UITableView_HistoryView_Width
								  , _container.contentSize.height);
	
	
	_column.frame = CGRectMake(_container.frame.size.width - UITableView_HistoryView_Width
							   , 0
							   , UITableView_HistoryView_Width
							   , _column.frame.size.height);
	
	
	[UIView commitAnimations];
	
}

-(void) hide:(id)sender{
	
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDuration: 0.25];
	[UIView setAnimationCurve: UIViewAnimationCurveEaseOut];
	[UIView setAnimationDidStopSelector:@selector(didHide:)];
	
	_tableView.frame = CGRectMake(_container.frame.size.width
								  , 0
								  , UITableView_HistoryView_Width
								  , _container.contentSize.height);
	
	
	_column.frame = CGRectMake(_container.frame.size.width
							   , 0
							   , UITableView_HistoryView_Width
							   , _column.frame.size.height);
	
	
	[UIView commitAnimations];
	
}

-(void) didHide:(id)sender{
	
	_tableView.hidden = YES;
	_column.hidden = YES;
}


#pragma mark - Render

-(UITableViewCell *) cellForId:(NSString *)prodId{
	
	UITableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:prodId];
	
	if(cell == nil){
		
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:prodId];
		
		cell.textLabel.text = @"..;";
		
		[cell addSubview:[UILabel labelWithRect:CGRectMake(565, 0, 85, 44) 
											tag:0 
										   text:@"?"]];
		
	}
	
	return cell;
}

@end
