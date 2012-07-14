//
//  SFSearchManager.h
//  OVCRM
//
//  Created by Apple on 10/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OVWebViewProtocal.h"

@interface SFSearchManager : NSObject

@property (nonatomic, retain) id<OVWebViewProtocal> delegate;
@property (nonatomic, retain) NSDictionary *fetched;
@property (nonatomic, retain) UISearchBar *searchBox;

- (void)searchBar:(UISearchBar *)searchBar search:(NSString *)text;

@end



@interface SFSearchManager (UITableViewHandler)<UITableViewDataSource, UITableViewDelegate>

@end
