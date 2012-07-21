//
//  OVCallCardController.h
//  OVCRM
//
//  Created by Apple on 20/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

#define CC_TAG_PRODUCT	10
#define CC_TAG_ON_SHELF	11
#define CC_TAG_IN_STOCK	12
#define CC_TAG_INV		100

#define CC_UI_OFFSET_ON_SHELF	415
#define CC_UI_OFFSET_IN_STORE	500


#define CC_UI_OFFSET_INV		575
#define CC_UI_SPACE_INV			105

#define CC_UI_OFFSET_ORD0		620

#define CC_UI_OFFSET_INV1		680
#define CC_UI_OFFSET_ORD1		725

#define CC_UI_OFFSET_INV2		785
#define CC_UI_OFFSET_ORD2		830

#define CC_UI_OFFSET_INV3		890
#define CC_UI_OFFSET_ORD3		935

@interface OVCallCardController : UIViewController{
	NSString *previousSearchText;
}


@property (nonatomic, retain) IBOutlet UISearchBar *searchBar;
@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *nextButton;

@property (nonatomic, retain) NSArray *product;
@property (nonatomic, retain) NSMutableArray *filtered;
@property (nonatomic, retain) NSMutableDictionary *callcard;
@property (nonatomic, retain) NSMutableDictionary *callcard_data;
@property (nonatomic, retain) NSDictionary *history;

@property (nonatomic, retain) NSString *planId;
@property (nonatomic, retain) NSString *accountId;


-(id)initWithPlanId:(NSString *)_planId 
		  accountId:(NSString *)_accountId;

-(void)save:(id)sender;
-(IBAction)next:(id)sender;

@end


@interface OVCallCardController (UITableViewHandler) <UITableViewDataSource, UITableViewDelegate>

@end


@interface OVCallCardController (UISearchBarDelegate)<UISearchBarDelegate>

@end
