//
//  OVCallCardController.m
//  OVCRM
//
//  Created by Apple on 20/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OVCallCardController.h"
#import "OVDatabase.h"

@implementation OVCallCardController

@synthesize searchBar, tableView, nextButton, columns, product, stock, stockData, planId, accountId;


-(id)initWithPlanId:(NSString *)_planId 
		  accountId:(NSString *)_accountId{
	
	self = [super init];
    if (self) {
        
		self.planId = _planId;
		self.accountId = _accountId;
		
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	
	[searchBar setTranslucent:YES];
	
	if ([[[searchBar subviews] objectAtIndex:0] isKindOfClass:[UIImageView class]]){
		[[[searchBar subviews] objectAtIndex:0] removeFromSuperview];
	}
	
	
	
	OVDatabase *db = [OVDatabase sharedInstance];
	
	if(!db.open)[db open];
	
	self.product = [[db executeQuery:
					 @"select p.* \
					 from	Product p \
					 join	MD_Product_Category__c md on \
					 md.Code__c = p.MD_Product_Category_Code__c \
					 where	p.Main_Product__c = '1' and p.isCancel <> 'Inactive' \
					 order by md.Runing_Number__c"] readToEnd];
	
	//@"select c.* from CallCard c join Plan p on p.Account_ID = c.Account_ID and date(p.Date_Plan) = date(c.CS_Date) where p.Id = '%@' limit 1"
	NSArray *callcard = [[db executeQuery:[NSString stringWithFormat:@"select c.* from CallCard c join Plan p on p.Account_ID = c.Account_ID and date(p.Date_Plan) = date(c.CS_Date) where p.Id = '%@' limit 1", self.planId]] readToEnd];
	
	if(callcard != nil && callcard.count > 0){
		self.stock = [NSMutableDictionary dictionaryWithDictionary:[callcard objectAtIndex:0]];
	}
	else {
		self.stock = [NSMutableDictionary new];
	}
	
	
	self.stockData = [NSMutableDictionary dictionaryWithDictionary:[[db executeQuery:@"Select * From CallCard_Stock where CallCard_PK = ?", [self.stock objectForKey:@"Id"]] readToEndById]];
	
	
	
	
	
	
	//[db executeQuery:@"select * from Merchandise where AccountId = ? and Date__c in (select ActivityDate from Plan where Id = ?)", "accId", "eventId"];
	
	
	//[[NSString alloc] initWithFormat:@"select c.* from CallCard c join Plan p on p.Account_ID = c.Account_ID and date(p.Date_Plan) = date(c.CS_Date) where p.Id = '%@' limit 1" ,plan_ID]; 
	
	//@"select * from Product where Main_Product__c = '1' and isCancel <> 'Inactive'"
	
	// load product
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
