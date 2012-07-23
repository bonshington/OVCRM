//
//  OVPCBriefViewController.m
//  OVCRM
//
//  Created by Warat Agatwipat on 7/21/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import "OVPCBriefViewController.h"
#import "OVDatabase.h"

@interface OVPCBriefViewController ()

@end

@implementation OVPCBriefViewController
@synthesize pcb_id,pcbdata,pcbrief,tempData;
@synthesize planId,accountId;
@synthesize textfeedback;
@synthesize textdisplayInfo;
@synthesize textpricingInfo;
@synthesize textofftakeInfo;

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
        textdisplayInfo.text = [pcbdic objectForKey:@"Display_Information__c"];
        textfeedback.text = [pcbdic objectForKey:@"PC_Merchandiser_Feedback__c"];
        textofftakeInfo.text = [pcbdic objectForKey:@"Offtake_Information__c"];
        textpricingInfo.text = [pcbdic objectForKey:@"Pricing_Information__c"];
        

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
    
	[db executeUpdate:@"Insert or Replace into PCBrief (Id , Pricing_Information__c , Source_System__c , pcbrief , Offtake_Information__c , PC_Merchandiser_Feedback__c , Display_Information__c , plan_ID , Account_Name__c) Values (?,?,?,?,?,?,?,?,?)",pcb_id,textpricingInfo.text,@"iPad",@"",textofftakeInfo.text,textfeedback.text,textdisplayInfo.text,planId,accountId];    
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
