//
//  OVMenuController.m
//  OVCRM
//
//  Created by Apple on 02/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OVMenuController.h"
#import "SFPlan.h"
#import "SFAccount.h"
#import "SFProduct.h"
#import "AppDelegate.h"
#import "OVLandingController.h"
#import "OVWebViewController.h"


@implementation OVMenuController

@synthesize checkinEventId, checkedAccountId, todayPlan, resultView, resultManager, tableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // init default page
    [[AppDelegate sharedInstance].detail pushViewController:[OVLandingController new] animated:NO];
    
    //init result table
    self.resultManager = [SFSearchManager new];
	self.resultManager.delegate = self;
	
    self.searchDisplayController.searchResultsDataSource = self.resultManager;
    self.searchDisplayController.searchResultsDelegate = self.resultManager;
    
    [self.tableView addSubview:self.resultView];
    
    
    
    // init menu
    self.todayPlan = [SFPlan selectToday];
    
    
    // init sync
    if(![self verifyDatabase]){
        [self sync];
    }
    
	
	
	// register upload change
	[[AppDelegate sharedInstance] registerUploadTaskChange:self];
	
	
    
    //BOOL dropped = [[AppDelegate sharedInstance].db executeUpdate:@"drop table Account"];
    //BOOL dropped = [[AppDelegate sharedInstance].db executeUpdate:@"drop table Event"];
    //BOOL ok = [[AppDelegate sharedInstance].db initSqlTableOf:[SFVisit new]];
    
    
    //[SFAccount loadAccountsWithRoute:@"10390230"];
    //[SFVisit loadNewVisit];
	
	//[[SFProduct new] sync:nil];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

-(BOOL) verifyDatabase{
    
    AppDelegate *app = [AppDelegate sharedInstance];
    app.db = [OVDatabase new];

    return app.db.open;
}

-(void) sync{
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:(UITableViewCell *)[self.tableView viewWithTag:tagForCellSF]];
    
    [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionBottom];
    
    [self tableView:self.tableView didSelectRowAtIndexPath:indexPath];
}


- (void) invokeSFObject:(NSString *)sObject 
		   withMustache:(NSDictionary *)data 
	 withRightBarButton:(UIBarButtonItem *)button{
	
	[[AppDelegate sharedInstance].detail pushViewController:[[OVWebViewController alloc] initForSFObject:sObject
																							withMustache:data 
																					  withRightBarButton:button]
												   animated:YES];

}

- (void) reloadData{
	[self.tableView reloadData];
}

-(void) setActive:(BOOL)isActive{
	
	self.tableView.allowsSelection = isActive;
	
	if(isActive){
	
		[self.searchDisplayController.searchBar setUserInteractionEnabled:YES];
		[self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
	}
	else{
		[self.searchDisplayController setActive:NO];
		[self.searchDisplayController.searchBar setUserInteractionEnabled:NO];
	}
}

-(void) updateUploadStatus:(int)tasksLeft{
	
	UITableViewCell *cell = (UITableViewCell *)[self.tableView viewWithTag:tagForCellSF];
	
	if(tasksLeft == 0){
		cell.accessoryView = [UIButton buttonWithType:UIButtonTypeInfoDark];
	}
	else{
		cell.accessoryView = [CustomBadge customBadgeWithString:[NSString stringWithFormat:@"%d", tasksLeft]
												withStringColor:[UIColor whiteColor] 
												 withInsetColor:[UIColor redColor] 
												 withBadgeFrame:YES 
											withBadgeFrameColor:[UIColor whiteColor] 
													  withScale:1.0
													withShining:YES];
	}
}

@end
