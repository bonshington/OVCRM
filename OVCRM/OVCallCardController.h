//
//  OVCallCardController.h
//  OVCRM
//
//  Created by Apple on 20/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface OVCallCardController : UIViewController


@property (nonatomic, retain) IBOutlet UISearchBar *searchBar;
@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *nextButton;
@property (nonatomic, retain) IBOutlet UIView *columns;

@property (nonatomic, retain) NSArray *product;
@property (nonatomic, retain) NSMutableDictionary *stock;
@property (nonatomic, retain) NSMutableDictionary *stockData;

@property (nonatomic, retain) NSString *planId;
@property (nonatomic, retain) NSString *accountId;


-(id)initWithPlanId:(NSString *)_planId 
		  accountId:(NSString *)_accountId;


@end


@interface OVCallCardController (UITableViewHandler) <UITableViewDataSource, UITableViewDelegate>

@end