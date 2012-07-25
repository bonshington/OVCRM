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
		
		
		[[_column subviews] enumerateObjectsUsingBlock:^(UIView *sub, NSUInteger index, BOOL *stop){
			sub.backgroundColor = [UIColor clearColor];
		}];
	
		
		// load data;
		NSString *accountId = [[AppDelegate sharedInstance].checkin objectForKey:@"AccountId"];
		_data = [[SFProduct sellingForAccount:accountId] dictionaryFromObjectForKey:@"Id"];
		
		
		
		
		
		/*
		 
		 
		 -(void) loadHistory{
		 self.history = [[[OVDatabase sharedInstance] executeQuery:
		 @"select 	st.prod_db_id__c \
		 , max(case when c0.Id = st.Stock__c then c0.Checking_Date__c else nil end) as date0 \
		 , max(case when c1.Id = st.Stock__c then c1.Checking_Date__c else nil end) as date1 \
		 , max(case when c2.Id = st.Stock__c then c2.Checking_Date__c else nil end) as date2 \
		 , max(case when c3.Id = st.Stock__c then c3.Checking_Date__c else nil end) as date3 \
		 \
		 , max(case when c0.Id = st.Stock__c then st.In_Stock__c else nil end) as inv0 \
		 , max(case when c1.Id = st.Stock__c then st.In_Stock__c else nil end) as inv1 \
		 , max(case when c2.Id = st.Stock__c then st.In_Stock__c else nil end) as inv2 \
		 , max(case when c3.Id = st.Stock__c then st.In_Stock__c else nil end) as inv3 \
		 \
		 from 	CallCard_Stock st \
		 left join (select Id, CS_Date from Call_Card__c where Id not like '-%' and Checking_Date__c <> date('now') order by Checking_Date__c desc limit 1, 0) c0 on c0.Id = st.Stock__c \
		 left join (select Id, CS_Date from Call_Card__c where Id not like '-%' and Checking_Date__c <> date('now') order by Checking_Date__c desc limit 1, 1) c1 on c1.Id = st.Stock__c \
		 left join (select Id, CS_Date from Call_Card__c where Id not like '-%' and Checking_Date__c <> date('now') order by Checking_Date__c desc limit 1, 2) c2 on c2.Id = st.Stock__c \
		 left join (select Id, CS_Date from Call_Card__c where Id not like '-%' and Checking_Date__c <> date('now') order by Checking_Date__c desc limit 1, 3) c3 on c3.Id = st.Stock__c \
		 group by st.prod_db_id__c"] 
		 readToEndBy:@"prod_db_id__c"];
		 }
		 
		 */
		
		
	}
	
	return self;
}

-(void) show:(id)sender{
	
	if(!_tableView.hidden)
		return;
	
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
	
	_tableView.frame = CGRectMake(containerWidth - UITableView_HistoryView_Width
								  , 0
								  , UITableView_HistoryView_Width
								  , _container.contentSize.height);
	
	
	_column.frame = CGRectMake(containerWidth - UITableView_HistoryView_Width
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
