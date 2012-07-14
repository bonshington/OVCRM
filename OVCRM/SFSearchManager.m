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
	
    OVDatabase *db = [AppDelegate sharedInstance].db;
    
    if(!db.open)[db open];
    
    text = [NSString stringWithFormat:@"%%%@%%", text];
    
    NSMutableDictionary *result = [NSMutableDictionary new];
    
    [result setObject:[[db executeQuery:@"select 'Account' as obj, Id, Name as label, Shop_Type__c as detail from Account where (Name LIKE ? or AccountNumber LIKE ? or Addr1__c LIKE ? or Amphur__c LIKE ? ) and Status__c = ? limit 25", text, text, text, text, @"Active"] readToEnd]
               forKey:@"Account"];
    
    
    // What as label or Account_Name__c as label?
    [result setObject:[[db executeQuery:@"select 'Event' as obj, Id, What as label, Description as detail from Event where (What like ? or Account_name__c like ? or StartDateTime like ?) limit 25", text, text, text] readToEnd]
               forKey:@"Event"];
    
    self.fetched = result;
}

@end
