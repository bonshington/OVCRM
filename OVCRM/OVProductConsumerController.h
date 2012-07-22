//
//  OVProductConsumerController.h
//  OVCRM
//
//  Created by Sopon Srisummasheep on 7/21/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "SFProduct.h"
#import "SFStepActionProtocal.h"


@interface OVProductConsumerController : UIViewController <UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate>{
	NSString *previousSearchText;
}

@property (nonatomic, retain) IBOutlet UISearchBar *searchBar;
@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) NSArray *product;
@property (nonatomic, retain) NSDictionary *indexing;
@property (nonatomic, retain) NSMutableArray *filtered;
@property (nonatomic, retain) NSString *planId;
@property (nonatomic, retain) NSString *accountId;

@property (nonatomic, retain) id<SFStepActionProtocal> delegate;


-(id)initWithPlanId:(NSString *)_planId 
		  accountId:(NSString *)_accountId;

-(void)checkout;

@end
