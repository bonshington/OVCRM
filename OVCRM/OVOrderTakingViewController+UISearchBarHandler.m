//
//  OVOrderTakingViewController+UISearchBarHandler.m
//  OVCRM
//
//  Created by Apple on 23/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OVOrderTakingViewController.h"

@implementation OVOrderTakingViewController (UISearchBarHandler)


- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
	
	if(previousSearchText == nil || ![searchText hasPrefix:previousSearchText]){
		
		self.filtered = [NSMutableArray arrayWithArray:self.product];
		
	}
	else{
		
		NSMutableArray *removing = [NSMutableArray new];
		
		for(NSDictionary *prod in self.filtered){
			if(!([[prod objectForKey:@"product_Category"] contains:searchText] 
				 ||[[prod objectForKey:@"product_Code"] contains:searchText]) ){
				
				[removing addObject:prod];
			}
		}
		
		for(id prod in removing)
			[self.filtered removeObject:prod];
	}
	
	[self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
	
	previousSearchText = searchText;
}

@end
