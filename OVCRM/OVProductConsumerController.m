//
//  OVProductConsumerController.m
//  OVCRM
//
//  Created by Sopon Srisummasheep on 7/21/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import "OVProductConsumerController.h"


@implementation OVProductConsumerController

@synthesize searchBar, tableView, product, filtered, planId, accountId, delegate, indexing;

-(id)initWithPlanId:(NSString *)_planId 
		  accountId:(NSString *)_accountId{
	
	self = [super init];
    if (self) {
        
		self.planId = _planId;
		self.accountId = _accountId;
		
    }
    return self;
}

-(void)checkout{
	
	[[OVDatabase sharedInstance] sfInsertInto:@"Plan" 
									 withData:[NSDictionary dictionaryWithObjectsAndKeys:
											   self.planId, @"Id", 
											   [[NSDate date] SFString], @"Time_Out__c",
											   nil]];
}


#pragma mark - UISearchViewDelegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
	
	if(previousSearchText == nil || ![searchText hasPrefix:previousSearchText]){
		
		self.filtered = [NSMutableArray arrayWithArray:self.product];
		
	}
	else{
		
		NSMutableArray *removing = [NSMutableArray new];
		
		for(NSDictionary *prod in self.filtered){
			if(!([[prod objectForKey:@"product_Category"] contains:searchText] 
				 ||[[prod objectForKey:@"product_Code"] contains:searchText]) ){
				
				[removing addObject:prod];
			}
		}
		
		for(id prod in removing)
			[self.filtered removeObject:prod];
	}
	
	[self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
	
	previousSearchText = searchText;
}


#pragma mark - UITableViewHandler

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	
	return self.filtered.count;
}


#pragma mark - Orientation

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return 
	(interfaceOrientation == UIDeviceOrientationLandscapeRight) || 
	(interfaceOrientation == UIDeviceOrientationLandscapeLeft);
}


#pragma mark - UI

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	[self.searchBar removeBackground];
	
	
	// add right buttons
	UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
	space.width = 50;
	
	self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:
											   [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self.delegate action:@selector(next:)], 
											   space, 
											   [[UIBarButtonItem alloc] initWithTitle:@"Checkout" style:UIBarButtonSystemItemCancel target:self.delegate action:@selector(checkout:)], 
											   nil];
	
	self.product = [SFProduct availableProduct];//[self.delegate loadProducts];
	
	NSMutableDictionary *_indexing = [NSMutableDictionary new];
	
	for(NSDictionary *row in self.product){
		[_indexing setObject:row forKey:[row objectForKey:@"Id"]];
	}
	
	self.indexing = _indexing;
	
	self.filtered = [NSMutableArray arrayWithArray:self.product];
}


@end
