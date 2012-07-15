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
#import "OVWebViewProtocal.h"
#import "CustomBadge.h"

@interface OVMenuController : UIViewController <OVWebViewProtocal, OVUploadProtocal>


@property(nonatomic, retain) IBOutlet UITableView *tableView;
@property(nonatomic, retain) IBOutlet UITableView *resultView;
@property(nonatomic, retain) NSString *checkinEventId;
@property(nonatomic, retain) NSString *checkedAccountId;
@property(nonatomic, retain) NSArray *todayPlan;
@property(nonatomic, retain) SFSearchManager *resultManager;

-(void) setActive:(BOOL)isActive;
-(void) reloadData;
-(BOOL) verifyDatabase;
-(void) sync;

- (void) invokeSFObject:(NSString *)sObject 
		   withMustache:(NSDictionary *)data 
	 withRightBarButton:(UIBarButtonItem *)button;

@end

@interface OVMenuController (CallVisit)



-(void) checkin;
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


