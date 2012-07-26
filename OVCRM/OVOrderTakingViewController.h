//
//  OVOrderTakingViewController.h
//  OVCRM
//
//  Created by Sopon Srisummasheep on 7/22/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OVProductConsumerController.h"
#import "OVHistoryManager.h"
#import "OVOrderSummaryManager.h"


@interface OVOrderTakingViewController : UIViewController{

	NSString *planId;
	NSString *accountId;
	NSString *previousSearchText;
	
	
	NSDictionary *sellable;
	NSDictionary *callcard;
	
	OVHistoryManager *historyManager;
	OVOrderSummaryManager *summaryManager;
	
	UISwipeGestureRecognizer *swipeOpenHistory;
	UISwipeGestureRecognizer *swipeCloseHistory;
	UISwipeGestureRecognizer *swipeOpenSummary;
	UISwipeGestureRecognizer *swipeCloseSummary;
	
	NSDictionary *promotionCriteria;
}

@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) IBOutlet UITableView *historyTable;
@property (nonatomic, retain) IBOutlet UISearchBar *searchBar;

@property (nonatomic, retain) IBOutlet UIView *historyColumn;

@property (nonatomic, retain) NSArray *product;
@property (nonatomic, retain) NSMutableArray *filtered;

@property (nonatomic, retain) NSMutableDictionary *data;
@property (nonatomic, retain) NSMutableDictionary *detail;


-(id)initWithPlanId:(NSString *)_planId 
		  accountId:(NSString *)_accountId;

-(void) loadData;
-(void)showSummary:(id)sender;

@end


@interface OVOrderTakingViewController (UITableViewHandler)<UITableViewDataSource, UITableViewDelegate>

-(UITableViewCell *) tableViewCell:(UITableViewCell *)cell callcardForIndexPath:(NSIndexPath *)indexPath;
-(UITableViewCell *) tableViewCell:(UITableViewCell *)cell productForData:(NSDictionary *)_data;

@end


@interface OVOrderTakingViewController (Action) <SFStepActionProtocal>

@end


@interface OVOrderTakingViewController (UISearchBarHandler) <UISearchBarDelegate>

@end