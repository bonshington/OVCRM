//
//  OVTradeProgramExeCTR.m
//  OVCRM
//
//  Created by Warat Agatwipat on 7/24/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import "OVTradeProgramExeCTR.h"
#import "OVDatabase.h"
#import "OVPCBriefCTR.h"

@interface OVTradeProgramExeCTR ()

@end

@implementation OVTradeProgramExeCTR

@synthesize accountId,planId;
@synthesize tempData,textTradeProgramResult,trade_id,tradedata,tradeprogram;

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
    [self.navigationItem setTitle:@"Trade Program Execution"];
    UIBarButtonItem * barButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(next:)];
    [self.navigationItem setRightBarButtonItem:barButton animated:YES];
    
    OVDatabase *db = [OVDatabase sharedInstance];
	
	if(!db.open)[db open];
	
    NSString * sql = [NSString stringWithFormat:@"Select Id, Account__c, Trade_Program_Result__c, Event_ID__c From Trade_Program_Execution__c Where event_id__c='%@'",planId];
    
    //    NSLog(@"%@",sql);
    
	self.tempData = [[db executeQuery:sql] readToEnd];
	self.tradedata = [NSMutableArray arrayWithArray:self.tempData];
    
    trade_id = [[NSString alloc]initWithFormat:@""];
    if (self.tradedata.count >= 1) {
        NSDictionary *tradedic = [self.tradedata objectAtIndex:0];
        tradedic = [tradedata objectAtIndex:0];
        trade_id = [tradedic objectForKey:@"Id"];
        //        textattechment.text = [compact objectForKey:@"Company_Information__c"];
        textTradeProgramResult.text = [tradedic objectForKey:@"Trade_Program_Result__c"];
        
    }

//    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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



#pragma SetTableView

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
	switch (section) {
		case 0: return @"Trade Program result"; break;

		default:return nil;
            
	}
}


-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	switch (indexPath.section) {
		case 0: return 650;
		default: return 1000;
	}
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    
    //    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    //    if (cell == nil) {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.row == 0) {
        switch (indexPath.section) {
            case 0:
                textTradeProgramResult.backgroundColor = [UIColor clearColor];
                [cell.contentView addSubview:textTradeProgramResult];
                break;
                
            default:
                break;
        }
    }
    return cell;    
}

-(void)next:(id)sender{
	
	OVDatabase *db = [OVDatabase sharedInstance];
    
	[db executeUpdate:@"Insert or Replace into Trade_Program_Execution__c (Id, Account__c, Trade_Program_Result__c, Event_ID__c ) Values (?,?,?,?)",trade_id,accountId,textTradeProgramResult.text,planId];    
    OVPCBriefCTR * nextView = [[OVPCBriefCTR alloc]initWithNibName:@"OVPCBriefCTR" bundle:nil];
    nextView.planId = planId;
    nextView.accountId = accountId;
    [self.navigationController pushViewController:nextView animated:YES];
}

@end
