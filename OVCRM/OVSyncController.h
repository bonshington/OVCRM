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
#import "SFPlan.h"
#import "SFStock.h"
#import "SFMerchandise.h"
#import "SFGoodsReturn.h"
#import "SFCollection.h"

#define OVSYNC_SECTION_UPLOAD   0
#define OVSYNC_SECTION_DOWNLOAD 1


@interface OVSyncController : UITableViewController

@property (nonatomic, retain) NSIndexPath *processing;
@property (nonatomic, retain) NSArray *upload;
@property (nonatomic, retain) NSDictionary *download;


-(void)sync;
-(void) upsertTo:(NSString *)table withData:(NSDictionary *)data;

@end


@interface OVSyncController (UITableViewController) <UITableViewDelegate, UITableViewDataSource>

@end


@interface OVSyncController (OVSyncProtocal) <OVSyncProtocal>

@end


@interface OVSyncController (UploadProcess)<SFRestDelegate>

-(void) upsert:(NSString *)uploadPk;

-(void) upsertInto:(NSString *)sfObject toId:(NSString *)objectId values:(NSDictionary *)values;

@end



@interface OVSyncController (SFRestDelegate)<SFRestDelegate>

@end