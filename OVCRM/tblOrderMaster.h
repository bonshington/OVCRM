//
//  tblOrderMaster.h
//  TestDB
//
//  Created by Warat Agatwipat on 7/9/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sqlite3.h"
#import "OVDataseProxy.h"

@interface tblOrderMaster : OVDataseProxy <OVDatabaseConsumeProtocal>

@property(nonatomic,strong) NSString *plan_ID;
@property(nonatomic,strong) NSString *pK;
@property(nonatomic,strong) NSString *order_Time;
@property(nonatomic,strong) NSString *order_Date;

@property (nonatomic,strong) NSDecimalNumber * order_Total;

@property(strong , nonatomic) NSMutableArray  *orderMasterList;

-(NSString *)DB_Field;

-(NSString *)GetMaxRnNo;

@end
