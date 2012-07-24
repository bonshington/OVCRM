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

#define UITableView_HistoryView_Width 355

@interface OVOrderTakingViewController : UIViewController{

	NSString *planId;
	NSString *accountId;
	NSString *previousSearchText;
	
	
	NSDictionary *callcard;
	OVHistoryManager *history;
}

@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) IBOutlet UITableView *historyView;
@property (nonatomic, retain) IBOutlet UISearchBar *searchBar;

@property (nonatomic, retain) IBOutlet UIView *columnView;
@property (nonatomic, retain) IBOutlet UIView *historyColumnView;

@property (nonatomic, retain) IBOutlet UIGestureRecognizer *swipeLeft;
@property (nonatomic, retain) IBOutlet UIGestureRecognizer *swipeRight;

@property (nonatomic, retain) NSArray *product;
@property (nonatomic, retain) NSMutableArray *filtered;
@property (nonatomic ,retain) NSMutableArray *selected;
@property (nonatomic, retain) NSMutableDictionary *data;



-(id)initWithPlanId:(NSString *)_planId 
		  accountId:(NSString *)_accountId;

-(void) loadData;

@end


@interface OVOrderTakingViewController (UITableViewHandler)<UITableViewDataSource, UITableViewDelegate>

-(UITableViewCell *) tableViewCell:(UITableViewCell *)cell callcardForIndexPath:(NSIndexPath *)indexPath;
-(UITableViewCell *) tableViewCell:(UITableViewCell *)cell productForData:(NSDictionary *)_data;

@end


@interface OVOrderTakingViewController (Action) <SFStepActionProtocal>

@end


@interface OVOrderTakingViewController (UISearchBarHandler) <UISearchBarDelegate>

@end