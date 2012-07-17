//
//  tblPromotion.h
//  TestDB
//
//  Created by Warat Agatwipat on 7/13/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "sqlite3.h"
#import "OVDataseProxy.h"

@interface tblPromotion : OVDataseProxy <OVDatabaseConsumeProtocal>

@property(nonatomic,strong) NSString *pK;
@property(nonatomic,strong) NSString *sale_ID;
@property(nonatomic,strong) NSString *promotionName;
@property(nonatomic,strong) NSString *quantityType;
@property(nonatomic,strong) NSString *saleMan;
@property(nonatomic,strong) NSString *value;
@property(nonatomic,strong) NSString *volumn;
@property(nonatomic,strong) NSString *shopType;
@property(nonatomic,strong) NSString *owner;
@property(nonatomic,strong) NSString *startDate;
@property(nonatomic,strong) NSString *endDate;

@property(strong , nonatomic) NSMutableArray  *promotionList;

-(NSString *)DB_Field;
//-(NSMutableArray *)QueryData:(NSString *)sqlText; 


@end
