//
//  Delivery.h
//  OvaltineTong0
//
//  Created by Warat Agatwipat on 6/25/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductDataDetail.h"
#import "CellDelivery.h"

@class ProductInAction;
@class tblOrderMaster;
@class tblOrderDetail;
@class tblDelivery;
@class tblDeliveryDetail;
@class tblProduct;
@class tblCalcPromotion;
@class viewDatePicker;

@interface Delivery : UIViewController
<UITableViewDataSource,UITableViewDelegate>
{
    NSString * account_ID;
    NSString * plan_ID;
    NSString * orderMaster_ID;
}

@property (strong, nonatomic) NSString * account_ID;
@property (strong, nonatomic) NSString * plan_ID;
@property (strong, nonatomic) NSString * orderMaster_ID;
@property (strong, nonatomic) NSMutableArray * muTableMaster;
@property (strong, nonatomic) NSMutableArray * muTableDetail;
@property (strong, nonatomic) tblOrderDetail * tblorderDetail;
@property (strong, nonatomic) tblOrderMaster * tblorderMaster;

@property (strong, nonatomic) tblDelivery * tbldelivery;
@property (strong, nonatomic) tblDeliveryDetail * tbldeliverydetail;
@property (assign, nonatomic) IBOutlet CellDelivery * cellDelivery;
@property (strong, nonatomic) IBOutlet UITableView *tableViewData;
@property (strong, nonatomic) tblProduct * tblproduct;
@property (strong, nonatomic) IBOutlet UILabel *lbDeliveryAmount;
@property (strong, nonatomic) IBOutlet UIButton *buttonDate;
@property (strong, nonatomic) IBOutlet viewDatePicker * viewdatepicker;
@property (strong, nonatomic) NSString * dateSelected;

@property (strong, nonatomic) NSArray * arrData0;
@property (strong, nonatomic) NSArray * arrData1;
@property (strong, nonatomic) NSArray * arrData2;
@property (strong, nonatomic) NSArray * arrData3;

@property (strong, nonatomic) IBOutlet ProductDataDetail * productDataDetail;
- (IBAction)buttonDateTouch:(UIButton *)sender;

@end
