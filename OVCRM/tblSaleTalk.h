//
//  tblSaleTalk.h
//  DBAppTest
//
//  Created by Admin on 6/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import <sqlite3.h>
#import "OVDataseProxy.h"

@interface tblSaleTalk : OVDataseProxy <OVDatabaseConsumeProtocal>

@property (nonatomic,strong) NSString *plan_ID;
@property (nonatomic,assign) NSString *Id;
@property (nonatomic,strong) NSString *saleTalk;
@property (nonatomic,strong) NSString *sT_Date;
@property (nonatomic,strong) NSString *sT_Time;

@property(strong , nonatomic) NSMutableArray  *saleTalkList;

-(NSString *)DB_Field;

/*
-(NSMutableArray *)QueryData:(NSString *)sqlText; 
-(bool)OpenConnection;
-(bool)ExecSQL : (NSString *)addText
 parameterArray:(NSArray *) paramArr;
*/


@end
