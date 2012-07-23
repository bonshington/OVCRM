//
//  OVPlanViewController+UISearchBarDelegate.m
//  OVCRM
//
//  Created by Apple on 23/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OVPlanViewController.h"

//UISearchBarDelegate

@implementation OVPlanViewController (UISearchBarHandler)

-(BOOL) searchBarShouldBeginEditing:(UISearchBar *)searchBar{
	[self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:2] 
						  atScrollPosition:UITableViewScrollPositionTop 
								  animated:YES];
	return true;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
	
	if(previousSearchText == nil || ![searchText hasPrefix:previousSearchText]){
		
		filtered = [NSMutableArray arrayWithArray:account];
		
	}
	else{
		
		NSMutableArray *removing = [NSMutableArray new];
		
		for(NSDictionary *acc in filtered){
			if(!([[acc objectForKey:@"Name"] contains:searchText] 
				 ||[[acc objectForKey:@"Amphur__c"] contains:searchText]
				 ||[[acc objectForKey:@"Addr1__c"] contains:searchText])){
				
				[removing addObject:acc];
			}
		}
		
		for(id acc in removing)
			[filtered removeObject:acc];
	}
	
	[self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:YES];
	
	if(filtered.count == 1){
		[self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:2] 
									animated:YES 
							  scrollPosition:UITableViewScrollPositionNone];
		
	}
	
	previousSearchText = searchText;
}

@end
