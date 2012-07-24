//
//  OVMenuController+UISearchBarDelegate.m
//  OVCRM
//
//  Created by Apple on 10/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OVMenuController.h"

@implementation OVMenuController (UISearchBarDelegate)

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    
    BOOL isSearching = [searchBar.text stringByReplacingOccurrencesOfString:@" " withString:@""].length > 0;
    
    self.tableView.hidden = isSearching;
    self.resultView.hidden = !isSearching;
    
    if(isSearching){
        [self.resultManager searchBar:searchBar search:searchBar.text];
    }
}


@end
