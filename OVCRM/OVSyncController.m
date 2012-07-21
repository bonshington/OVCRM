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
    
    //self.tableView.allowsSelection = NO;

	self.upload = [[[OVDatabase sharedInstance] executeQuery:
					@"select * from Upload \
					where syncTime is null \
					order by \
						case when sObject = 'Event' then 0 \
							when sObject = 'Call_Card__c' then 1 \
							when sObject = 'Stock__c' then 2 \
						end, createTime"] readToEnd];
    
    self.download = [NSDictionary dictionaryWithObjectsAndKeys:
                     
					 [SFAccount new], @"Account", 
					 [SFPlan new], @"Plan", 
					 [SFStock new], @"Stock",
                     [SFProduct new], @"Product", 
					 [SFMerchandise new], @"Merchandise",
					 [SFGoodsReturn new], @"Goods Return",
					 [SFCollection new], @"Collection",
					 [SFCallCard new], @"Call Card",
					 [SFPriceBook new], @"Price book",
					 [SFPriceBookDetail new], @"Price book detail",
					 [SFPCBrief new], @"PC Brief",
					 [SFSalesTalk new], @"Sales Talk",
					 [SFMDProductCat new], @"Product Master Data",
					 
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
	self.processing = [NSIndexPath indexPathForRow:0 inSection:2];
    
    [self sync];
}


-(void)sync{
    
    [self.tableView selectRowAtIndexPath:self.processing animated:YES scrollPosition:UITableViewScrollPositionNone];
    
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:self.processing];
    
    switch (self.processing.section) {
			
		case OVSYNC_SECTION_MY_DATA:
			[[SFUser new] sync:self];
			break;
			
        case OVSYNC_SECTION_UPLOAD:
            [self upsert:[self.upload objectAtIndex:uploading forKey:@"pk"]];
            break;
            
        case OVSYNC_SECTION_DOWNLOAD:
            [(id<SFObjectProtocal>)[self.download objectForKey:cell.textLabel.text] sync:self];
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
