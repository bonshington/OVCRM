//
//  OVSyncController.h
//  OVCRM
//
//  Created by Apple on 09/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SFObjectProtocal.h"
#import "OVSyncProtocal.h"
#import "AppDelegate.h"

#import "SFAccount.h"
#import "SFProduct.h"
#import "SFVisit.h"

#define OVSYNC_SECTION_UPLOAD   0
#define OVSYNC_SECTION_DOWNLOAD 1


@interface OVSyncController : UITableViewController

@property (nonatomic, retain) NSIndexPath *processing;
@property (nonatomic, retain) NSDictionary *upload;
@property (nonatomic, retain) NSDictionary *download;

-(void)sync;

@end


@interface OVSyncController (UITableViewController) <UITableViewDelegate, UITableViewDataSource>

@end


@interface OVSyncController (OVSyncProtocal) <OVSyncProtocal>

@end