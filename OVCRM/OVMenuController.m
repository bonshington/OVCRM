//
//  OVMenuController.m
//  OVCRM
//
//  Created by Apple on 02/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OVMenuController.h"
#import "SFVisit.h"
#import "AppDelegate.h"


@implementation OVMenuController

@synthesize checkedinAccount, todayPlan;

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
    // Do any additional setup after loading the view from its nib.
    
    [AppDelegate sharedInstance].db = [OVDatabase new];
    
    //[SFAccount loadAccountsWithRoute:@"10390230"];
    
    
    //BOOL ok = [[AppDelegate sharedInstance].db initSqlTableOf:[SFVisit new]];
    
    [SFVisit loadNewVisit];
    
    
    FMResultSet *result = [SFVisit selectToday];
    NSMutableArray *plan = [NSMutableArray new];
    
    while([result next]){
        
        [plan addObject:[result resultDictionary]];
    }

    self.todayPlan = plan;
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

@end
