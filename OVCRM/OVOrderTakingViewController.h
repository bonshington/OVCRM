//
//  OVOrderTakingViewController.h
//  OVCRM
//
//  Created by Sopon Srisummasheep on 7/22/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OVProductConsumerController.h"


@interface OVOrderTakingViewController : UIViewController{

	NSString *previousSearchText;
}

@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) IBOutlet UISearchBar *searchBar;

@property (nonatomic, retain) NSArray *product;
@property (nonatomic, retain) NSMutableArray *filtered;
@property (nonatomic ,retain) NSMutableArray *selected;

@end


@interface OVOrderTakingViewController (UITableViewHandler)<UITableViewDataSource, UITableViewDelegate>

-(UITableViewCell *) tableView:(UITableView *)tableView selectRowAtIndexPath:(NSIndexPath *)indexPath;
-(UITableViewCell *) tableView:(UITableView *)tableView productRowAtIndexPath:(NSIndexPath *)indexPath;

@end


@interface OVOrderTakingViewController (Action) <SFStepActionProtocal>

@end


@interface OVOrderTakingViewController (UISearchBarHandler) <UISearchBarDelegate>

@end