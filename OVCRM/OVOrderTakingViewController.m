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
	
	
	[self.searchBar setTranslucent:YES];
	
	if ([[[self.searchBar subviews] objectAtIndex:0] isKindOfClass:[UIImageView class]]){
		[[[self.searchBar subviews] objectAtIndex:0] removeFromSuperview];
	}
	
	callcard = [[AppDelegate sharedInstance].checkin objectForKey:@"CallCard_Data"];
	
	
	[[self.historyColumnView subviews] enumerateObjectsUsingBlock:^(UIView *sub, NSUInteger index, BOOL *stop){
		sub.backgroundColor = [UIColor clearColor];
	}];
	
	
	// load/resume
	self.selected = [NSMutableArray new];
	
	
	originalHistoryFrame = CGRectMake(self.tableView.frame.size.width
									  , 0
									  , UITableView_HistoryView_Width
									  , 0);
	
	
	[self.tableView addSubview:self.historyView];
	
	
	// add gesture recognition
	[self.tableView addGestureRecognizer:self.swipeLeft];
	//[self.tableView addGestureRecognizer:self.swipeRight];
	[self.historyView addGestureRecognizer:self.swipeRight];
	
	self.historyView.scrollEnabled = NO;
	self.historyView.hidden = YES;
	
	self.product = [SFProduct availableProduct];
	self.filtered = [NSMutableArray arrayWithArray:self.product];
	
	
	self.title = @"Order Taking";
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
	
	return (interfaceOrientation == UIDeviceOrientationLandscapeRight) || (interfaceOrientation == UIDeviceOrientationLandscapeLeft);
}

-(IBAction)showHistory:(id)sender{
	
	self.historyView.hidden = NO;
	
	self.historyView.frame = CGRectMake(self.tableView.frame.size.width
										, 0
										, UITableView_HistoryView_Width
										, self.tableView.contentSize.height);
	
	
	[UIView beginAnimations:nil context: NULL];
	[UIView setAnimationDuration: 0.25];
	[UIView setAnimationCurve: UIViewAnimationCurveEaseInOut];
	
	self.historyView.frame = CGRectMake(self.tableView.frame.size.width - UITableView_HistoryView_Width
									   , 0
									   , UITableView_HistoryView_Width
									   , self.tableView.contentSize.height);
	
	self.historyColumnView.frame = CGRectMake(self.tableView.frame.size.width - UITableView_HistoryView_Width
											  , 0
											  , UITableView_HistoryView_Width
											  , self.historyColumnView.frame.size.height);
	
	[UIView commitAnimations];
}

-(IBAction)hideHistory:(id)sender{
	
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDuration: 0.25];
	[UIView setAnimationCurve: UIViewAnimationCurveEaseInOut];
	[UIView setAnimationDidStopSelector:@selector(doneHideHistory:)];
	
	self.historyView.frame = CGRectMake(self.tableView.frame.size.width
										, 0
										, UITableView_HistoryView_Width
										, self.tableView.contentSize.height);
	
	self.historyColumnView.frame = CGRectMake(self.tableView.frame.size.width
											  , 0
											  , UITableView_HistoryView_Width
											  , self.historyColumnView.frame.size.height);
	
	[UIView commitAnimations];
}

-(IBAction)doneHideHistory:(id)sender{
	self.historyView.hidden = YES;
}

@end
