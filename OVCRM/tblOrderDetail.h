//
//  tblOrderDetail.h
//  TestDB
//
//  Created by Warat Agatwipat on 7/9/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sqlite3.h"
#import "OVDataseProxy.h"

@interface tblOrderDetail : OVDataseProxy <OVDatabaseConsumeProtocal>

@property(nonatomic,strong) NSString *pK;
@property(nonatomic,strong) NSString *product_ID;
@property(nonatomic,strong) NSString *product_Name;
@property(nonatomic,strong) NSString *discount_Rate;
@property(nonatomic,strong) NSString *orderMaster_PK;

@property (nonatomic,strong) NSDecimalNumber * suggest;
@property (nonatomic,strong) NSDecimalNumber * total;
@property (nonatomic,strong) NSDecimalNumber * totalDiscount;
@property (nonatomic,strong) NSDecimalNumber * discount;
@property (nonatomic,strong) NSDecimalNumber * price;
@property (nonatomic,strong) NSDecimalNumber * totalPrice;
@property (nonatomic,strong) NSDecimalNumber * quantity;
@property (nonatomic,strong) NSDecimalNumber * salesPrice;


@property(strong , nonatomic) NSMutableArray  *orderDetailList;

-(NSString *)DB_Field;
//-(NSMutableArray *)QueryData:(NSString *)sqlText; 
-(NSMutableArray *)QueryData2:(NSString *)sqlText; 
-(NSMutableArray *)loadDataTakeOrderWithSuggestForAccountID:(NSString *)Account_ID;
-(NSMutableArray *)QueryDataForDeivery:(NSString *)sqlText;

-(NSString *)GetMaxRnNo;

@end
