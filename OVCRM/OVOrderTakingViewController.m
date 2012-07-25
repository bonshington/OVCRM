//
//  OVOrderTakingViewController.m
//  OVCRM
//
//  Created by Sopon Srisummasheep on 7/22/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import "OVOrderTakingViewController.h"
#import "SFPromotionCriteria.h"



@implementation OVOrderTakingViewController

@synthesize tableView, historyTable, searchBar, filtered, product, data, historyColumn;


-(id)initWithPlanId:(NSString *)_planId 
		  accountId:(NSString *)_accountId{
	
	self = [super init];
    if (self) {
        
		planId = _planId;
		accountId = _accountId;
		
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	
	
	[self.searchBar removeBackground];
	
	[self loadData];
	
	
	historyManager = [[OVHistoryManager alloc] initWithTableView:self.historyTable 
														  column:self.historyColumn
													   container:self.tableView];
	
	
	// add gesture recognition
	swipeOpenHistory = [[UISwipeGestureRecognizer alloc] initWithTarget:historyManager action:@selector(show:)];
	swipeCloseHistory = [[UISwipeGestureRecognizer alloc] initWithTarget:historyManager action:@selector(hide:)];
	
	swipeOpenSummary = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(showSummary:)];
	swipeCloseSummary = [[UISwipeGestureRecognizer alloc] initWithTarget:summaryManager action:@selector(hide:)];
	
	
	swipeOpenHistory.direction = UISwipeGestureRecognizerDirectionLeft;
	swipeCloseHistory.direction = UISwipeGestureRecognizerDirectionRight;
	
	swipeOpenSummary.direction = UISwipeGestureRecognizerDirectionRight;
	swipeOpenSummary.direction = UISwipeGestureRecognizerDirectionLeft;
	
	
	self.title = @"Order Taking";
	
}

-(void) viewDidAppear:(BOOL)animated{
	
	[self.tableView addGestureRecognizer:swipeOpenHistory];
	[self.historyTable addGestureRecognizer:swipeCloseHistory];
	
	[self.tableView addGestureRecognizer:swipeOpenSummary];
	[summaryManager.view addGestureRecognizer:swipeCloseSummary];
}

-(void) viewDidDisappear:(BOOL)animated{
	
	[self.tableView removeGestureRecognizer:swipeOpenHistory];
	[self.historyTable removeGestureRecognizer:swipeCloseHistory];
	
	[self.tableView removeGestureRecognizer:swipeOpenSummary];
	[summaryManager.view removeGestureRecognizer:swipeCloseSummary];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
	
	return (interfaceOrientation == UIDeviceOrientationLandscapeRight) || (interfaceOrientation == UIDeviceOrientationLandscapeLeft);
}

-(void) loadData{
	
	promotionCriteria = [SFPromotionCriteria current];
	
	callcard = [[AppDelegate sharedInstance].checkin objectForKey:@"CallCard_Data"];
	
	self.product = [SFProduct sellingForAccount:accountId];
	self.filtered = [NSMutableArray arrayWithArray:self.product];
	
	self.data = [NSMutableDictionary new];
	
	// load exist
	[[OVDatabase sharedInstance] executeQuery:@""];
	
	
	// load resume
	
	
}

-(void)showSummary:(id)sender{
	[summaryManager showWithData:self.data];
}


@end
