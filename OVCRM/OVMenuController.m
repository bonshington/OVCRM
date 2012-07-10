//
//  OVMenuController.m
//  OVCRM
//
//  Created by Apple on 02/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OVMenuController.h"
#import "SFVisit.h"
#import "SFAccount.h"
#import "AppDelegate.h"
#import "OVLandingController.h"


@implementation OVMenuController

@synthesize checkedinAccount, todayPlan, resultView, resultManager, tableView;

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
    self.searchDisplayController.searchResultsDataSource = self.resultManager;
    self.searchDisplayController.searchResultsDelegate = self.resultManager;
    
    [self.tableView addSubview:self.resultView];
    
    
    
    // init menu
    FMResultSet *result = [SFVisit selectToday];
    NSMutableArray *plan = [NSMutableArray new];

    while([result next]){
    
        [plan addObject:[result resultDictionary]];
    }

    self.todayPlan = plan;
    
    
    // init sync
    if(![self verifyDatabase]){
        [self sync];
    }
    
    
    //BOOL dropped = [[AppDelegate sharedInstance].db executeUpdate:@"drop table Account"];
    //BOOL dropped = [[AppDelegate sharedInstance].db executeUpdate:@"drop table Event"];
    //BOOL ok = [[AppDelegate sharedInstance].db initSqlTableOf:[SFVisit new]];
    
    
    //[SFAccount loadAccountsWithRoute:@"10390230"];
    //[SFVisit loadNewVisit];
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
    
    if(!app.db.open) [app.db open];
    
    FMResultSet *result = [app.db executeQuery:@"select 1 from Parameter"];
    
    BOOL valid = result != nil && result.hasAnotherRow;
    
    [result close];
    
    
    if (!valid){    
        NSArray *initScript = [[NSArray alloc] initWithObjects:
                               @"create table if not exists Parameter(tag TEXT, key TEXT, label TEXT)", 
                               @"insert into Parameter(tag, key, label) values('CONFIG', 'LAST_SYNC', '2000-01-01')",
                               nil];
        
        [app.db beginTransaction];
        
        for (NSString *script in initScript) {
            [app.db executeUpdate:script];
        }
        
        [app.db commit];
    }
    
    return valid;
}

-(void) sync{
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:(UITableViewCell *)[self.tableView viewWithTag:tagForCellSF]];
    
    [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionBottom];
    
    [self tableView:self.tableView didSelectRowAtIndexPath:indexPath];
}

@end
