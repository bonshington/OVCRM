//
//  OVOrderTakingViewController.m
//  OVCRM
//
//  Created by Sopon Srisummasheep on 7/22/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import "OVOrderTakingViewController.h"




@implementation OVOrderTakingViewController

@synthesize tableView, historyView, searchBar, filtered, product, selected, data, swipeLeft, swipeRight, columnView, historyColumnView;


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
	
	
	[[self.historyColumnView subviews] enumerateObjectsUsingBlock:^(UIView *sub, NSUInteger index, BOOL *stop){
		sub.backgroundColor = [UIColor clearColor];
	}];
	
	
	// load/resume
	self.selected = [NSMutableArray new];
	
	
	history = [[OVHistoryManager alloc] initWithTableView:self.historyView 
												   column:self.historyColumnView 
												container:self.tableView];
	
	
	// add gesture recognition
	[self.swipeLeft addTarget:history action:@selector(show:)];
	[self.swipeRight addTarget:history action:@selector(hide:)];
	
	
	[self.tableView addGestureRecognizer:self.swipeLeft];
	[self.historyView addGestureRecognizer:self.swipeRight];
	
	
	self.product = [SFProduct sellingForAccount:accountId];
	self.filtered = [NSMutableArray arrayWithArray:self.product];
	
	
	self.title = @"Order Taking";
	
	
	
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
	
	return (interfaceOrientation == UIDeviceOrientationLandscapeRight) || (interfaceOrientation == UIDeviceOrientationLandscapeLeft);
}

-(void) loadData{
	
	
	// load exist
	
	// load resume
	
	
}


@end
