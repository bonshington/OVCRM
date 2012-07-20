//
//  tblDeliveryDetail.h
//  TestDB
//
//  Created by Warat Agatwipat on 7/17/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "sqlite3.h"

#import "OVDataseProxy.h"

@interface tblDeliveryDetail : OVDataseProxy <OVDatabaseConsumeProtocal>

@property (strong, nonatomic) NSDecimalNumber * total;
@property (strong, nonatomic) NSDecimalNumber * totalDiscount;
@property (strong, nonatomic) NSString * delivery_PK;
@property (strong, nonatomic) NSString * pk;
@property (strong, nonatomic) NSString * Product_ID;
@property (strong, nonatomic) NSDecimalNumber * quantity;
@property (strong, nonatomic) NSDecimalNumber * price;
@property (strong, nonatomic) NSDecimalNumber * totalPrice;
@property (strong, nonatomic) NSDecimalNumber * discountRate;
@property (strong, nonatomic) NSDecimalNumber * discount;

@property(strong , nonatomic) NSMutableArray  *deliveryDetailList;

-(NSString *)DB_Field;

/*
-(NSMutableArray *)QueryData:(NSString *)sqlText; 
-(bool)OpenConnection;
-(bool)ExecSQL : (NSString *)addText
 parameterArray:(NSArray *) paramArr;

-(NSString *)GetMaxRnNo;
*/

@end
