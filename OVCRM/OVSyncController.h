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
#import "SFCallCard.h"
#import "SFPriceBook.h"
#import "SFPriceBookDetail.h"
#import "SFUser.h"
#import "SFPCBrief.h"
#import "SFSalesTalk.h"
#import "SFMDProductCat.h"
#import "SFCompetitive.h"
#import "SFTradeProg.h"
#import "SFARDetail.h"
#import "SFAR.h"
#import "SFPromotion.h"
#import "SFPromotionCriteria.h"
#import "SFPromotionLine.h"
#import "SFPromotionDiscount.h"
#import "SFOrderTaking.h"
#import "SFOrderDetail.h"

#define OVSYNC_SECTION_MY_DATA	0
#define OVSYNC_SECTION_UPLOAD	1
#define OVSYNC_SECTION_DOWNLOAD 2


@interface OVSyncController : UITableViewController{
	NSUInteger uploading;
}

@property (nonatomic, retain) NSIndexPath *processing;
@property (nonatomic, retain) NSArray *upload;
@property (nonatomic, retain) NSDictionary *download;
@property (nonatomic, retain) UIProgressView *progress;
@property (nonatomic, retain) NSDictionary *sending;
@property (nonatomic, retain) NSMutableDictionary *mapping;


-(void)sync;
-(void) upsertTo:(NSString *)table withData:(NSDictionary *)data;

@end


@interface OVSyncController (UITableViewController) <UITableViewDelegate, UITableViewDataSource>

@end


@interface OVSyncController (OVSyncProtocal) <OVSyncProtocal>

@end


@interface OVSyncController (UploadProcess)

-(void) upsert:(NSString *)uploadPk;


@end



@interface OVSyncController (SFRestDelegate)<SFRestDelegate>

@end


