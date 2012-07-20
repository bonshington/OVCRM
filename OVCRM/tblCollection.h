//
//  tblCollection.h
//  TestDB
//
//  Created by Warat Agatwipat on 7/5/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "sqlite3.h"
#import "OVDataseProxy.h"

@interface tblCollection : OVDataseProxy <OVDatabaseConsumeProtocal>

@property(nonatomic,strong) NSString *plan_ID;
@property(nonatomic,strong) NSString *pK;
@property(nonatomic,strong) NSString *collect_Date;
@property(nonatomic,strong) NSString *collect_Time;
@property(nonatomic,strong) NSString *invoice_No;
@property(nonatomic,strong) NSString *amount;
@property(nonatomic,strong) NSString *payType;
@property(nonatomic,strong) NSString *bank;
@property(nonatomic,strong) NSString *branch;
@property(nonatomic,strong) NSString *chequeNo;
@property(nonatomic,strong) NSString *totalPay;

@property(strong , nonatomic) NSMutableArray  *collectionList;

-(NSString *)DB_Field;


//-(NSString *)GetMaxRnNo;

@end
