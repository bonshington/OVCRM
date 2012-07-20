//
//  SalesNote.m
//  OvaltineTong0
//
//  Created by Warat Agatwipat on 6/22/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import "SalesNote.h"
#import "tblSaleTalk.h"
#import "tblPCBrief.h"
#import "GoodsReturn.h"

@interface SalesNote ()

@end

@implementation SalesNote

@synthesize st_Id,pcb_Id;
@synthesize plan_ID;
@synthesize account_ID;
@synthesize tblsaleTalk;
@synthesize tblpcBrief;

@synthesize textSalesTalk;
@synthesize lblPCBrief;
@synthesize textPCBrief;

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
    tblsaleTalk = [[tblSaleTalk alloc]init];
    tblpcBrief = [[tblPCBrief alloc]init];
    
    st_Id = [[NSString alloc]init];
    pcb_Id = [[NSString alloc]init];
    //[super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setTextSalesTalk:nil];
    [self setTextPCBrief:nil];
    [self setLblPCBrief:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}


- (IBAction)touchView:(id)sender {
    [textSalesTalk resignFirstResponder];
    [textPCBrief resignFirstResponder];
}

-(void) setSalesTalkPage{
    [self setTitle:@"Ovaltine(ST)"];
    UIBarButtonItem * barButtonNext = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(nextToGoodReturn)];
    [self.navigationItem setRightBarButtonItem:barButtonNext animated:YES];
    
    textPCBrief.editable = NO;
    textSalesTalk.editable = YES;
    [lblPCBrief setHidden:YES];
    [textPCBrief setHidden:YES];
    if ([tblsaleTalk OpenConnection] == YES)
    {
        [self loadDataSaleTalk];
    }
}
-(void) loadDataSaleTalk
{
//    NSString *tableField = [tblsaleTalk DB_Field] ;//[[NSString alloc]init];                
//    NSString *searchString = [[NSString alloc] initWithFormat:@"select %@ from SaleTalk",tableField]; 
//    NSMutableArray * arrSaleTalk = [[NSMutableArray alloc] init];
//    arrSaleTalk=[tblsaleTalk QueryData:searchString];
    NSMutableArray * arrSaleTalk = [self getArrSaleTalk];
    if (arrSaleTalk.count != 0)
    {
        textSalesTalk.text = [[arrSaleTalk objectAtIndex:arrSaleTalk.count-1] saleTalk];
        st_Id = [[arrSaleTalk objectAtIndex:arrSaleTalk.count-1] Id];
    }
}

-(void) saveDataSaleTalk
{
    NSDate *now = [NSDate date];
    NSLog(@"now: %@", now); // now: 2011-02-28 09:57:49 +0000 
    NSString *strDate = [self dateToString:now];
    NSString *strTime = [self timeToString:now];
    
    
    NSArray *paramArray ;    
    NSMutableArray * arrSaleTalk = [self getArrSaleTalk];
    NSString * sql;
    NSLog(@"%d",arrSaleTalk.count);
    paramArray = [[NSArray alloc] initWithObjects:st_Id,plan_ID,textSalesTalk.text, nil];
    sql = [NSString stringWithFormat:@"Insert or replace Into SaleTalk (Id,plan_ID,saleTalk) Values (?,?,?)"];
//    if (arrSaleTalk.count < 1){
//        paramArray = [[NSArray alloc] initWithObjects:plan_ID,textSalesTalk.text,strDate,strTime, nil];
//        
//        sql = [NSString stringWithFormat:@"Insert or replace Into SaleTalk (plan_ID,saleTalk,Id) Values (?,?,?)"];
//    }else {
//        paramArray = [[NSArray alloc] initWithObjects:textSalesTalk.text, plan_ID, nil];
//        sql = [NSString stringWithFormat:@"Update SaleTalk Set SaleTalk = ? Where Plan_ID = ?"];
//    }
    [tblsaleTalk ExecSQL:sql parameterArray:paramArray];
}


-(NSMutableArray *)getArrSaleTalk
{
    NSString *tableField = [tblsaleTalk DB_Field] ;
    NSString *searchString = [[NSString alloc] initWithFormat:@"select %@ from SaleTalk Where plan_ID='%@'",tableField,plan_ID]; 
    NSLog(@"%@",searchString);
    NSMutableArray * arrSaleTalk = [[NSMutableArray alloc] init];
    arrSaleTalk = [tblsaleTalk QueryData:searchString];
    return  arrSaleTalk;
}



/////////////////////////////////////////////////////////////////////////////

-(void) setPCBriefPage{
    [self setTitle:@"Ovaltine(PCB)"];
    UIBarButtonItem * barButtonNext = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(nextToEnd)];
    [self.navigationItem setRightBarButtonItem:barButtonNext animated:YES];
    
    textPCBrief.editable = YES;
    textSalesTalk.editable = NO;
    [lblPCBrief setHidden:NO];
    [textPCBrief setHidden:NO];
    if ([tblpcBrief OpenConnection] == YES)
    {
        [self loadDataSaleTalk];
        [self loadDataPCBrief];
    }
}

-(void) loadDataPCBrief
{
//    NSString *tableField = [tblpcBrief DB_Field] ;
//    NSString *searchString = [[NSString alloc] initWithFormat:@"select %@ from PCBrief",tableField]; 
//    NSMutableArray * arrPCBrief = [[NSMutableArray alloc] init];
//    arrPCBrief=[tblpcBrief QueryData:searchString];
    NSMutableArray * arrPCBrief = [self getArrPCBrief];
    if (arrPCBrief.count != 0)
    {
        textPCBrief.text = [[arrPCBrief objectAtIndex:arrPCBrief.count-1] saleTalk];
        pcb_Id = [[arrPCBrief objectAtIndex:arrPCBrief.count-1] Id];
    }
}

-(void) saveDataPCBrief
{
    NSDate *now = [NSDate date];
    NSLog(@"now: %@", now); // now: 2011-02-28 09:57:49 +0000 
    NSString *strDate = [self dateToString:now];
    NSString *strTime = [self timeToString:now];
    
    NSArray *paramArray ;//= [[NSArray alloc] initWithObjects:@"0",textPCBrief.text,strDate,strTime, nil];
//    NSMutableArray * arrPCBrief = [self getArrPCBrief];
    NSString * sql;
    paramArray = [[NSArray alloc] initWithObjects:pcb_Id,plan_ID,textPCBrief.text, nil];
    sql = [NSString stringWithFormat:@"Insert or Update Into PCBrief (Id,plan_ID,pcBrief) Values (?,?,?)"];//PCB_Date,PCB_Time
//    
//    if (arrPCBrief.count < 1){
//        paramArray = [[NSArray alloc] initWithObjects:plan_ID,textPCBrief.text, nil];
//
//        sql = [NSString stringWithFormat:@"Insert or Update Into PCBrief (plan_ID,pcBrief,Id) Values (?,?,?)"];//PCB_Date,PCB_Time
//    }else {
//        paramArray = [[NSArray alloc] initWithObjects:textPCBrief.text, plan_ID, nil];
//        sql = [NSString stringWithFormat:@"Update PCBrief Set PCBrief = ? Where Plan_ID = ?"];
//    }
    [tblpcBrief ExecSQL:sql parameterArray:paramArray];
}

-(NSMutableArray *)getArrPCBrief
{
    NSString *tableField = [tblpcBrief DB_Field] ;
    NSString *searchString = [[NSString alloc] initWithFormat:@"select %@ from PCBrief Where Plan_ID='%@'",tableField,plan_ID]; 
    NSMutableArray * arrPCBrief = [[NSMutableArray alloc] init];
    arrPCBrief=[tblpcBrief QueryData:searchString];
    return  arrPCBrief;
}


/////////////////////////////////////////////////////////////////////////////


-(NSString *)dateToString:(NSDate*)sDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeStyle:NSDateFormatterNoStyle];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"th_TH"];//@"en_US"];
    [dateFormatter setLocale:usLocale];
    return [dateFormatter stringFromDate:sDate];
}

-(NSString *)timeToString:(NSDate*)sDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateStyle:NSDateFormatterNoStyle];
    NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"th_TH"];//@"en_US"];
    [dateFormatter setLocale:usLocale];
    return [dateFormatter stringFromDate:sDate];
}

-(void) nextToGoodReturn
{
    [self saveDataSaleTalk];
    GoodsReturn * nextView = [[GoodsReturn alloc]initWithNibName:@"GoodsReturn" bundle:nil];
    nextView.account_ID = account_ID;
    nextView.plan_ID = plan_ID;
    [self.navigationController pushViewController:nextView animated:YES];
}

-(void) nextToEnd
{
    [self saveDataPCBrief];
    [self.navigationController popToRootViewControllerAnimated:YES];
}




@end
