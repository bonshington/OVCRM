//
//  OVMenuController.h
//  OVCRM
//
//  Created by Apple on 02/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFSearchManager.h"
#import "Appdelegate.h"

@interface OVMenuController : UIViewController 

@property(nonatomic, retain) IBOutlet UITableView *tableView;
@property(nonatomic, retain) IBOutlet UITableView *resultView;
@property(nonatomic, retain) NSDictionary *checkedinAccount;
@property(nonatomic, retain) NSArray *todayPlan;
@property(nonatomic, retain) SFSearchManager *resultManager;

-(BOOL) verifyDatabase;
-(void) sync;

@end

@interface OVMenuController (CallVisit)



-(void) checkinWithAccountId:(char *) accountID;
-(void) checkout;
-(void) plan;
-(void) viewAccountId:(char *) accountId;
-(void) pushViewController:(char *)name;

@end


@interface OVMenuController (MenuTableViewhandler)<UITableViewDelegate, UITableViewDataSource>

@end


@interface OVMenuController (Render)

-(UITableViewCell *)tableView:(UITableView *)tableView planForRowAtIndexPath:(NSIndexPath *)indexPath;
-(UITableViewCell *)tableView:(UITableView *)tableView checkinForRowAtIndexPath:(NSIndexPath *)indexPath;
-(UITableViewCell *)tableView:(UITableView *)tableView menuForRowAtIndexPath:(NSIndexPath *)indexPath;
-(UITableViewCell *)tableView:(UITableView *)tableView sfForRowAtIndexPath:(NSIndexPath *)indexPath;

@end


@interface OVMenuController (UISearchBarDelegate) <UISearchBarDelegate>

@end


