//
//  OVCompetitiveCTR.m
//  OVCRM
//
//  Created by Warat Agatwipat on 7/24/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import "OVCompetitiveCTR.h"
#import "OVTradeProgramExeCTR.h"
#import "OVDatabase.h"

@interface OVCompetitiveCTR ()

@end

@implementation OVCompetitiveCTR
@synthesize textProduct,textCompany,textIFeb,textPromotion,tableDataView;
@synthesize planID,accountID;
@synthesize tempData,comacdata,compat_id,competitive;

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
    [self.navigationItem setTitle:@"Competitive Activity"];
    UIBarButtonItem * barButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(next:)];
    [self.navigationItem setRightBarButtonItem:barButton animated:YES];
    
    OVDatabase *db = [OVDatabase sharedInstance];
	
	if(!db.open)[db open];
	
    NSString * sql = [NSString stringWithFormat:@"Select Id , account__c , competitor_s_product__c , ifab_information__c , promotion_information__c , name , company_information__c , event_id__c From Competitive_Activities__c Where event_id__c='%@'",planID];// Where event_id__c='%@'
    //    NSLog(@"%@",sql);
	self.tempData = [[db executeQuery:sql] readToEnd];
	self.comacdata = [NSMutableArray arrayWithArray:self.tempData];
    
    compat_id = [[NSString alloc]initWithFormat:@""];
    if (self.comacdata.count >= 1) {
        NSDictionary *compact = [self.comacdata objectAtIndex:0];
        compact = [comacdata objectAtIndex:0];
        textCompany.text = [compact objectForKey:@"Company_Information__c"];
        textIFeb.text = [compact objectForKey:@"iFab_Information__c"];
        textProduct.text = [compact objectForKey:@"Competitor_s_Product__c"];
        textPromotion.text = [compact objectForKey:@"Promotion_Information__c"];
        compat_id = [compact objectForKey:@"Id"];
    }
//     [super viewDidLoad];
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


-(void)next:(id)sender{
	
	OVDatabase *db = [OVDatabase sharedInstance];
    
	[db executeUpdate:@"Insert or Replace into Competitive_Activities__c (Id , Competitor_s_Product__c , iFab_Information__c , Promotion_Information__c , Company_Information__c ,Event_ID__c,Account__c) Values (?,?,?,?,?,?,?)",compat_id,textProduct.text,textIFeb.text,textPromotion.text,textCompany.text,planID,accountID];    
    OVTradeProgramExeCTR * nextView = [[OVTradeProgramExeCTR alloc]initWithNibName:@"OVTradeProgramExeCTR" bundle:nil];
    nextView.planId = planID;
    nextView.accountId = accountID;
    [self.navigationController pushViewController:nextView animated:YES];
}


#pragma SetTableView

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

-(NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
	switch (section) {
		case 0: return @"Competitive Product"; break;
			
		case 1: return @"Competitive Product"; break;
			
		case 2: return @"iFab Information"; break;
            
        case 3: return @"Promotion Information"; break;
			
		default:return nil;
	}
}


-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	switch (indexPath.section) {
		case 0: return 50;			
		case 1: return 130;
		case 2: return 130;
		case 3: return 130;
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
                textProduct.backgroundColor = [UIColor clearColor];
                [cell.contentView addSubview:textProduct];
                break;
            case 1:
                textCompany.backgroundColor = [UIColor clearColor];
                [cell.contentView addSubview:textCompany];
                break;
            case 2:
                textIFeb.backgroundColor = [UIColor clearColor];
                [cell.contentView addSubview:textIFeb];
                break;
            case 3:
                textPromotion.backgroundColor = [UIColor clearColor];
                [cell.contentView addSubview:textPromotion];
                break;
                
            default:
                break;
        }
    }
    return cell;    
}


@end
