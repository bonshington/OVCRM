//
//  SFSearchManager.m
//  OVCRM
//
//  Created by Apple on 10/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SFSearchManager.h"
#import "AppDelegate.h"

@implementation SFSearchManager

@synthesize fetched, delegate, searchBox;

- (void)searchBar:(UISearchBar *)searchBar search:(NSString *)text;{
    
	self.searchBox = searchBar;
	
	AppDelegate *app = [AppDelegate sharedInstance];
    OVDatabase *db = app.db;
    
    if(!db.open)[db open];
    
    text = [NSString stringWithFormat:@"%%%@%%", text];
    
    NSMutableDictionary *result = [NSMutableDictionary new];
	
	// build up params
	NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
								   text, @"text", 
								   nil];
	
	
	// query with same structure for all
    [result setObject:[[db executeQuery:
						@"select 'Account' as obj, Id, Name as label, Shop_Type__c as detail \
						from	Account \
						where	(Name LIKE :text or AccountNumber LIKE :text or Addr1__c LIKE :text or Amphur__c LIKE :text ) and Status__c = 'Active' \
						limit 25" 
				withParameterDictionary:params] readToEnd]
               forKey:@"Account"];
    
    
    [result setObject:[[db executeQuery:
						@"select 'Event' as obj, Id, What as label, Description as detail \
						from	Event \
						where	(What like :text or Account_name__c like :text or StartDateTime like :text) \
						limit 25"
				withParameterDictionary:params] 
					   readToEnd]
               forKey:@"Event"];
	
	
	
	
	if(app.checkin != nil && [app.checkin objectForKey:@"AccountId"] != nil){
		
		//for pricebook lookup
		[params setObject:[app.checkin objectForKey:@"AccountId"] forKey:@"AccountId"];
		
		[result setObject:[[db executeQuery:
						   @"select 'Product' as obj, Id, Short_Name__c as label, product_category__c as detail \
						   from		ProductPriceList \
						   where	ProductPrice_PK in (select Id from ProductPrice where Account = :AccountId and Active__c = '1') \
							and Status__c = 'Active' \
							and Is_Main__c = 'True' \
							and (Product_Category__c like :text \
								or	ProductName like :text \
								or  Class__c like :text \
						   )limit 25" 
				   withParameterDictionary:params
						   ] readToEnd]
				   forKey:@"Product"];
	}
    
    self.fetched = result;
}

@end
