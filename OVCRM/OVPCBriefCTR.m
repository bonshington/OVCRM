//
//  OVPCBriefCTR.m
//  OVCRM
//
//  Created by Warat Agatwipat on 7/24/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import "OVPCBriefCTR.h"
#import "OVDatabase.h"

@interface OVPCBriefCTR ()

@end

@implementation OVPCBriefCTR
@synthesize pcb_id,pcbdata,pcbrief,tempData;
@synthesize planId,accountId;
@synthesize tableDataView;
@synthesize textviewPC;
@synthesize textDisplay;
@synthesize textPricing;
@synthesize textOfftake;

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
    [self.navigationItem setTitle:@"PC Brief Description"];
    UIBarButtonItem * barButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(next:)];
    [self.navigationItem setRightBarButtonItem:barButton animated:YES];
    
    OVDatabase *db = [OVDatabase sharedInstance];
	
	if(!db.open)[db open];
	
    NSString * sql = [NSString stringWithFormat:@"Select Id , Attachment__c , Pricing_Information__c , Source_System__c , pcbrief , Offtake_Information__c , PC_Merchandiser_Feedback__c , Display_Information__c , plan_ID , Account_Name__c From PCBrief Where plan_ID='%@'",planId];
    
        NSLog(@"%@",sql);
    
	self.tempData = [[db executeQuery:sql] readToEnd];
	self.pcbdata = [NSMutableArray arrayWithArray:self.tempData];
    
    pcb_id = [[NSString alloc]initWithFormat:@""];
    if (self.pcbdata.count >= 1) {
        NSDictionary *pcbdic = [self.pcbdata objectAtIndex:0];
        pcbdic = [pcbdata objectAtIndex:0];
        pcb_id = [pcbdic objectForKey:@"Id"];
        textDisplay.text = [pcbdic objectForKey:@"Display_Information__c"];
        textviewPC.text = [pcbdic objectForKey:@"PC_Merchandiser_Feedback__c"];
        textOfftake.text = [pcbdic objectForKey:@"Offtake_Information__c"];
        textPricing.text = [pcbdic objectForKey:@"Pricing_Information__c"];
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

-(void)next:(id)sender{
	
	OVDatabase *db = [OVDatabase sharedInstance];
    
	[db executeUpdate:@"Insert or Replace into PCBrief (Id , Pricing_Information__c , Source_System__c , pcbrief , Offtake_Information__c , PC_Merchandiser_Feedback__c , Display_Information__c , plan_ID , Account_Name__c) Values (?,?,?,?,?,?,?,?,?)",pcb_id,textPricing.text,@"IPAD",@"",textOfftake.text,textviewPC.text,textDisplay.text,planId,accountId];    
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}




#pragma SetTableView

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

-(NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
	switch (section) {
		case 0: return @"PC/Merchandiser Feedback"; break;
			
		case 1: return @"Display Information"; break;
			
		case 2: return @"Pricing Information"; break;
            
        case 3: return @"Offtake Information"; break;
			
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
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 
                                                   reuseIdentifier:CellIdentifier];
    
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    //    }
    //    cellView = [[UIView alloc]initWithFrame:CGRectMake(0.0, 0.0, tableView.frame.size.width, 50)];
    if (indexPath.row == 0) {
        switch (indexPath.section) {
            case 0:
                textviewPC.backgroundColor = [UIColor clearColor];//.frame = cell.frame;
                [cell.contentView addSubview:textviewPC];
//                [textviewPC setText:@"Complete!"];
                //                [cellView addSubview:textviewPC];
                break;
            case 1:
                textDisplay.backgroundColor = [UIColor clearColor];//.frame = cell.frame;
                [cell.contentView addSubview:textDisplay];
//                [textDisplay setText:@"Complete!"];
                //                [cellView addSubview:textDisplay];
                break;
            case 2:
                textPricing.backgroundColor = [UIColor clearColor];//.frame = cell.frame;
                [cell.contentView addSubview:textPricing];
//                [textPricing setText:@"Complete!"];
                //                [cellView addSubview:textPricing];
                break;
            case 3:
                textOfftake.backgroundColor = [UIColor clearColor];//.frame = cell.frame;
                [cell.contentView addSubview:textOfftake];
//                [textOfftake setText:@"Complete!"];
                //                [cellView addSubview:textOfftake];
                break;
                
            default:
                textviewPC.backgroundColor = [UIColor clearColor];
                [cell.contentView addSubview:textOfftake];
//                [textOfftake setText:@"Not Complete!"];
                //                [cellView addSubview:textOfftake];
                break;
        }
    }
    return cell;    
}

@end
