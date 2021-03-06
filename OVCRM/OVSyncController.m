//
//  OVSyncController.m
//  OVCRM
//
//  Created by Apple on 09/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OVSyncController.h"
#import "OVMenuController.h"


@implementation OVSyncController

@synthesize upload, download, processing, progress, sending, mapping;

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
	uploading = 0;
	
	self.mapping = [NSMutableDictionary new];
	
    [super viewDidLoad];
	
	self.tableView.userInteractionEnabled = NO;
    
#pragma mark - Clear indexing
	
	[AppDelegate sharedInstance].product = nil;

	self.upload = [[[OVDatabase sharedInstance] executeQuery:
					@"select * from Upload \
					where syncTime is null \
					order by \
						case when sObject = 'Event' then 0 \
							when sObject = 'Call_Card__c' then 1 \
							when sObject = 'Stock__c' then 2 \
						end, createTime"] readToEnd];
    
    self.download = [NSDictionary dictionaryWithObjectsAndKeys:
                     
					 [SFAccount new]	, @"Account", 
					 [SFPlan new]		, @"Plan", 
					 [SFStock new]		, @"Stock",
                     [SFProduct new]	, @"Product", 
					 [SFMerchandise new], @"Merchandise",
					 [SFGoodsReturn new], @"Goods Return",
					 [SFCollection new]	, @"Collection",
					 [SFCallCard new]	, @"Call Card",
					 [SFPriceBook new]	, @"Price book",
					 [SFPriceBookDetail new], @"Price book detail",
					 [SFPCBrief new]	, @"PC Brief",
					 [SFSalesTalk new]	, @"Sales Talk",
					 [SFMDProductCat new], @"Product Master Data",
					 
					 [SFCompetitive new], @"Competitive Activities",
					 [SFTradeProg new]	, @"Trade Program Execution",
					 
					 [SFAR new], @"AR", 
					 [SFARDetail new], @"AR Detail", 
					 
					 [SFPromotion new], @"Promotion",
					 [SFPromotionCriteria new], @"Promotion Criteria",
					 //[SFPromotionDiscount new], @"Promotion DIscount",
					 [SFPromotionLine new], @"Promotion Items",
					 
					 [SFOrderTaking new], @"Order",
					 [SFOrderDetail new], @"Order Detail",
					
                     nil];
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

-(void)viewDidAppear:(BOOL)animated{
    
    // begin
	self.processing = [NSIndexPath indexPathForRow:0 inSection:0];
    
    [self sync];
}


-(void)sync{
    
    [self.tableView selectRowAtIndexPath:self.processing animated:YES scrollPosition:UITableViewScrollPositionNone];
    
    //UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:self.processing];
    
    switch (self.processing.section) {
			
		case OVSYNC_SECTION_MY_DATA:
			[[SFUser new] sync:self];
			break;
			
        case OVSYNC_SECTION_UPLOAD:
			if(self.upload == nil || self.upload.count == uploading)
				[self done];
			else
				[self upsert:[self.upload objectAtIndex:uploading forKey:@"pk"]];
            break;
            
        case OVSYNC_SECTION_DOWNLOAD:
            [(id<SFObjectProtocal>)[self.download objectAtIndex:self.processing.row] sync:self];
            break;
    }
    
}


#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex{
	[self.navigationController popViewControllerAnimated:YES];
	
	// refresh things
	OVMenuController *menu = (OVMenuController *)[AppDelegate sharedInstance].master;
	[menu setActive:YES];
	[menu reloadData];
}

@end
