//
//  OVOrderTakingViewController.m
//  OVCRM
//
//  Created by Sopon Srisummasheep on 7/22/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import "OVOrderTakingViewController.h"
#import "SFPromotionCriteria.h"
#import "OVOrderSummaryManager.h"


@implementation OVOrderTakingViewController

@synthesize tableView, historyTable, searchBar, filtered, product, data, historyColumn, detail;


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
	
	self.title = @"Order Taking";
	
	[self.searchBar removeBackground];
	
	[self loadData];
	
	summaryManager = [[OVOrderSummaryManager alloc] initWithTableView:self.tableView];
	
	
	historyManager = [[OVHistoryManager alloc] initWithTableView:self.historyTable 
														  column:self.historyColumn
													   container:self.tableView];
	
	
	/* init gesture */
	swipeOpenHistory = [[UISwipeGestureRecognizer alloc] initWithTarget:historyManager action:@selector(show:)];
	swipeCloseHistory = [[UISwipeGestureRecognizer alloc] initWithTarget:historyManager action:@selector(hide:)];
	
	swipeOpenSummary = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(showSummary:)];
	swipeCloseSummary = [[UISwipeGestureRecognizer alloc] initWithTarget:summaryManager action:@selector(hide:)];
	
	
	swipeOpenHistory.direction = UISwipeGestureRecognizerDirectionLeft;
	swipeCloseHistory.direction = UISwipeGestureRecognizerDirectionRight;
	
	swipeOpenSummary.direction = UISwipeGestureRecognizerDirectionRight;
	swipeCloseSummary.direction = UISwipeGestureRecognizerDirectionLeft;
	/****************/
	
	
	
	
	// add right buttons
	UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
	space.width = 50;
	
	self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:
											   [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(next:)],
											   space,
											   [[UIBarButtonItem alloc] initWithTitle:@"Checkout" style:UIBarButtonSystemItemCancel target:self action:@selector(checkout:)],
											   nil];
}

-(void) viewDidAppear:(BOOL)animated{
	
	[self.tableView addGestureRecognizer:swipeOpenHistory];
	[self.historyTable addGestureRecognizer:swipeCloseHistory];
	
	[self.tableView addGestureRecognizer:swipeOpenSummary];
	[summaryManager.tableView addGestureRecognizer:swipeCloseSummary];
}

-(void) viewDidDisappear:(BOOL)animated{
	
	[self.tableView removeGestureRecognizer:swipeOpenHistory];
	[self.historyTable removeGestureRecognizer:swipeCloseHistory];
	
	[self.tableView removeGestureRecognizer:swipeOpenSummary];
	[summaryManager.tableView removeGestureRecognizer:swipeCloseSummary];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
	
	return (interfaceOrientation == UIDeviceOrientationLandscapeRight) || (interfaceOrientation == UIDeviceOrientationLandscapeLeft);
}

-(void) loadData{
	
	NSDictionary *checkin = [AppDelegate sharedInstance].checkin;
	
	promotionCriteria = [SFPromotionCriteria current];
	
	callcard = [checkin objectForKey:@"CallCard_Data"];
	
	self.product = [SFProduct sellableForAccount:accountId];
	self.filtered = [NSMutableArray arrayWithArray:self.product];
	
	// index
	[AppDelegate sharedInstance].sellable = [self.product dictionaryFromObjectForKey:@"Products_Database__c"];
	
	
	self.data = [NSMutableDictionary new];
	// load data
	NSArray *existingData = [[[OVDatabase sharedInstance] executeQuery:@"select * from Order_Taking__c where EventID__c = ? limit 1", planId] readToEnd];
	
	if(existingData != nil && existingData.count > 0)
		self.data = [existingData objectAtIndex:0];
	
	
	NSArray *resumeData = [[[OVDatabase sharedInstance] executeQuery:@"select * from Upload where planId = ? and sObject = 'Order_Taking__c' and syncTime is null limit 1", planId] readToEnd];
	
	if(resumeData != nil && resumeData.count > 0){
		self.data = [resumeData objectAtIndex:0];
	}
	
	// create new data if not found
	if(self.data.count == 0){
		self.data = [NSMutableDictionary dictionaryWithObjectsAndKeys:
					 accountId, @"Account_Name__c", 
					 planId, @"EventID__c",
					 @"IPAD", @"Source_System__c",
					 @"-", @"Id",
					 nil];
	}
	
	
	self.detail = [NSMutableDictionary new];
	// load detail
	NSArray *existingDetail = [[[OVDatabase sharedInstance] executeQuery:@"select * from Opportunity_Product__c where Order_Taking__c = ?", [self.data objectForKey:@"Id"]] readToEnd];
	
	[existingDetail enumerateObjectsUsingBlock:^(NSDictionary *row, NSUInteger index, BOOL *stop){
		[self.detail setObject:row forKey:[row objectForKey:@"Products_Database_ID__c"]];
	}];
	
	// load resume detail
	NSArray *resumeDetail = [[[OVDatabase sharedInstance] executeQuery:@"select * from Upload where planId = ? and sObject = 'Opportunity_Product__c' and syncTime is null", planId] readToEnd];
	
	[resumeDetail enumerateObjectsUsingBlock:^(NSDictionary *row, NSUInteger index, BOOL *stop){
		
		NSDictionary *json =  [SFJsonUtils objectFromJSONString:[row objectForKey:@"json"]];
		
		[self.detail setObject:json forKey:[json objectForKey:@"Opportunity_Product__c"]];
	}];
}

-(void)showSummary:(id)sender{
	
	[self.view endEditing:YES];
	
	[summaryManager showWithData:self.detail];
}


@end
