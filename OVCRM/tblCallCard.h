//
//  CallCard.h
//  DBAppTest
//
//  Created by Admin on 6/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import <sqlite3.h>
#import "OVDataseProxy.h"

@interface tblCallCard : OVDataseProxy <OVDatabaseConsumeProtocal>

@property(nonatomic,strong) NSString *plan_ID;
@property(nonatomic,strong) NSString *Id;
@property(nonatomic,strong) NSString *account_ID;
@property(nonatomic,strong) NSString *cS_Date;
@property(nonatomic,strong) NSString *cS_Time;

@property(strong , nonatomic) NSMutableArray  *callCardList;

-(NSString *)DB_Field;
//-(NSString *)GetMaxRnNo;

/*
-(NSMutableArray *)QueryData:(NSString *)sqlText; 
-(bool)OpenConnection;
-(bool)ExecSQL : (NSString *)addText
 parameterArray:(NSArray *) paramArr;
*/




@end
