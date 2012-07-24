//
//  OVOrderTakingViewController.m
//  OVCRM
//
//  Created by Sopon Srisummasheep on 7/22/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import "OVOrderTakingViewController.h"




@implementation OVOrderTakingViewController

@synthesize tableView, historyTable, searchBar, filtered, product, selected, data, historyColumn;


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
	
	
	callcard = [[AppDelegate sharedInstance].checkin objectForKey:@"CallCard_Data"];
	
	
	// load/resume
	self.selected = [NSMutableArray new];
	
	
	historyManager = [[OVHistoryManager alloc] initWithTableView:self.historyTable 
														  column:self.historyColumn
													   container:self.tableView];
	
	
	// add gesture recognition
	swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:historyManager action:@selector(show:)];
	swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:historyManager action:@selector(hide:)];
	swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
	swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
	
	
	self.product = [SFProduct sellingForAccount:accountId];
	self.filtered = [NSMutableArray arrayWithArray:self.product];
	
	
	self.title = @"Order Taking";
	
}

-(void) viewDidAppear:(BOOL)animated{
	
	[self.tableView addGestureRecognizer:swipeLeft];
	[self.historyTable addGestureRecognizer:swipeRight];
}

-(void) viewDidDisappear:(BOOL)animated{
	[self.tableView removeGestureRecognizer:swipeLeft];
	[self.historyTable removeGestureRecognizer:swipeRight];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
	
	return (interfaceOrientation == UIDeviceOrientationLandscapeRight) || (interfaceOrientation == UIDeviceOrientationLandscapeLeft);
}

-(void) loadData{
	
	
	// load exist
	
	// load resume
	
	
}


@end
