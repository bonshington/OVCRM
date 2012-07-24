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

@interface OVMenuController : UIViewController <OVWebViewProtocal, OVUploadProtocal>{
	NSString *planId;
	NSString *accountId;
}


@property(nonatomic, retain) IBOutlet UITableView *tableView;
@property(nonatomic, retain) IBOutlet UITableView *resultView;

//@property(nonatomic, retain) NSString *checkinEventId;
//@property(nonatomic, retain) NSString *checkedAccountId;

@property(nonatomic, retain) NSArray *todayPlan;
@property(nonatomic, retain) SFSearchManager *resultManager;

-(void) setActive:(BOOL)isActive;
-(void) reloadData;
-(BOOL) verifyDatabase;
-(void) sync;
-(void) loadData;
-(void) openPlan:(id)sender;
-(void) checkin:(id)sender;

- (void) invokeSFObject:(NSString *)sObject 
		   withMustache:(NSDictionary *)data 
	 withRightBarButton:(UIBarButtonItem *)button;



@end


@interface OVMenuController (UITableViewHandler)<UITableViewDelegate, UITableViewDataSource>

-(UITableViewCell *)tableView:(UITableView *)tableView planForRowAtIndexPath:(NSIndexPath *)indexPath;
-(UITableViewCell *)tableView:(UITableView *)tableView checkinForRowAtIndexPath:(NSIndexPath *)indexPath;
-(UITableViewCell *)tableView:(UITableView *)tableView menuForRowAtIndexPath:(NSIndexPath *)indexPath;
-(UITableViewCell *)tableView:(UITableView *)tableView sfForRowAtIndexPath:(NSIndexPath *)indexPath;

@end


@interface OVMenuController (Render)



@end


@interface OVMenuController (UISearchBarDelegate) <UISearchBarDelegate>

@end


