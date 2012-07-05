//
//  OVMenuController.h
//  OVCRM
//
//  Created by Apple on 02/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OVMenuController : UITableViewController <UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, retain) NSDictionary *checkedinAccount;


@end

@interface OVMenuController (CallVisit)



-(void) checkinWithAccountId:(char *) accountID;
-(void) checkout;
-(void) plan;
-(void) viewAccountId:(char *) accountId;
-(void) pushViewController:(char *)name;

@end
