//
//  tblDelivery.h
//  TestDB
//
//  Created by Warat Agatwipat on 7/17/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "sqlite3.h"
#import "OVDataseProxy.h"

@interface tblDelivery : OVDataseProxy <OVDatabaseConsumeProtocal>

@property (strong, nonatomic) NSString * plan_ID;
@property (strong, nonatomic) NSString * pk;
@property (strong, nonatomic) NSString * delivery_Date;
@property (strong, nonatomic) NSString * dr_Date;
@property (strong, nonatomic) NSString * dr_Time;

@property(strong , nonatomic) NSMutableArray  *deliveryList;


-(NSString *)DB_Field;
/*
-(NSMutableArray *)QueryData:(NSString *)sqlText; 
-(bool)OpenConnection;
-(bool)ExecSQL : (NSString *)addText
 parameterArray:(NSArray *) paramArr;

-(NSString *)GetMaxRnNo;
*/
@end
