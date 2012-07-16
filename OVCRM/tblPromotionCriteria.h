//
//  tblPromotionCriteria.h
//  TestDB
//
//  Created by Warat Agatwipat on 7/13/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sqlite3.h"
@interface tblPromotionCriteria : NSObject

//Promotion_PK,PK,Sale_ID,Quantity,Amount,Product_Code
@property(nonatomic,strong) NSString *promotion_PK;
@property(nonatomic,strong) NSString *pk;
@property(nonatomic,strong) NSString *sale_ID;
@property(nonatomic,strong) NSDecimalNumber *quantity;
@property(nonatomic,strong) NSDecimalNumber *amount;
@property(nonatomic,strong) NSString *product_Code;
@property(strong , nonatomic) NSMutableArray  *promotionCriteriaList;

-(NSString *)DB_Field;
-(NSMutableArray *)QueryData:(NSString *)sqlText; 
-(bool)OpenConnection;
-(bool)ExecSQL : (NSString *)addText
 parameterArray:(NSArray *) paramArr;

@end
