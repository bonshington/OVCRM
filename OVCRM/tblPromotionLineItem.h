//
//  tblPromotionLineItem.h
//  TestDB
//
//  Created by Warat Agatwipat on 7/13/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sqlite3.h"
#import "OVDataseProxy.h"

@interface tblPromotionLineItem : OVDataseProxy <OVDatabaseConsumeProtocal>

//Promotion_PK,PK,Sale_ID,Product_Code,Brand,Product_Family
@property (strong, nonatomic) NSString * promotion_PK;
@property (strong, nonatomic) NSString * pK;
@property (strong, nonatomic) NSString * sale_ID;
@property (strong, nonatomic) NSString * product_Code;
@property (strong, nonatomic) NSString * brand;
@property (strong, nonatomic) NSString * product_Family;
@property(strong , nonatomic) NSMutableArray *promotionLineItemList;

-(NSString *)DB_Field;
//-(NSMutableArray *)QueryData:(NSString *)sqlText; 


@end
