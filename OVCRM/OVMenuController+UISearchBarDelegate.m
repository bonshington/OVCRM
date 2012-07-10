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
        [self.resultManager search:searchBar.text];
    }
}

/*
 
 @optional
 
 - (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar;                      // return NO to not become first responder
 - (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar;                     // called when text starts editing
 - (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar;                        // return NO to not resign first responder
 - (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar;                       // called when text ends editing
 - (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText;   // called when text changes (including clear)
 - (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_3_0); // called before text changes
 
 - (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar;                     // called when keyboard search button pressed
 - (void)searchBarBookmarkButtonClicked:(UISearchBar *)searchBar;                   // called when bookmark button pressed
 - (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar;                    // called when cancel button pressed
 - (void)searchBarResultsListButtonClicked:(UISearchBar *)searchBar __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_3_2); // called when search results button pressed
 
 - (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope __OSX_AVAILABLE_STARTING(__MAC_NA,__IPHONE_3_0);
 
*/

@end
