//
//  OVSyncController.m
//  OVCRM
//
//  Created by Apple on 09/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OVSyncController.h"


@implementation OVSyncController

@synthesize upload, download, processing;

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
    
    //self.tableView.allowsSelection = NO;

    self.upload = [NSDictionary dictionaryWithObjectsAndKeys:
                   @"", @"test task1", 
                   @"", @"test task2", 
                   @"", @"test task3", 
                   nil];
    
    self.download = [NSDictionary dictionaryWithObjectsAndKeys:
                     [SFAccount new], @"Account", 
                     [SFProduct new], @"Product", 
                     [SFVisit new], @"Visit", 
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
    self.processing = [NSIndexPath indexPathForRow:0 inSection:1];
    
    [self sync];
}


-(void)sync{
    
    [self.tableView selectRowAtIndexPath:self.processing animated:YES scrollPosition:UITableViewScrollPositionNone];
    
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:self.processing];
    
    switch (self.processing.section) {
        case OVSYNC_SECTION_UPLOAD:
            ;
            break;
            
        case OVSYNC_SECTION_DOWNLOAD:
            [(id<SFObjectProtocal>)[self.download objectForKey:cell.textLabel.text] sync:self];
            break;
    }
    
}

@end
