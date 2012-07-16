//
//  tblCalcPromotion.h
//  TestDB
//
//  Created by Warat Agatwipat on 7/13/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sqlite3.h"
#import "OVDataseProxy.h"

@interface tblCalcPromotion : OVDataseProxy <OVDatabaseConsumeProtocal>

//PK, PromotionName, ItemOrder, Quantity, Amount, ItemPromotion
@property (strong, nonatomic) NSString * pk;
@property (strong, nonatomic) NSString * promotionName;
@property (strong, nonatomic) NSString * itemOrder;
@property (strong, nonatomic) NSDecimalNumber * orderQuantity;
@property (strong, nonatomic) NSDecimalNumber * orderAmount;
@property (strong, nonatomic) NSDecimalNumber * quantity;
@property (strong, nonatomic) NSDecimalNumber * amount;
@property (strong, nonatomic) NSDecimalNumber * free;
@property (strong, nonatomic) NSString * itemPromotion;
@property (strong, nonatomic) NSMutableArray * tblcalcPromotion;

-(NSString *)DB_Field;
-(NSMutableArray *)QueryPromotionWithProductCodeIn:(NSString *) productCodeString;


@end
