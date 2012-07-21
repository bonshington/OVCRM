//
//  tblMerchandize.h
//  TestDB
//
//  Created by Warat Agatwipat on 7/5/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OVDataseProxy.h"

@interface tblMerchandize : OVDataseProxy <OVDatabaseConsumeProtocal>

@property(nonatomic,strong) NSString *plan_ID;
@property(nonatomic,strong) NSString *Id;
@property(nonatomic,strong) NSString *account_ID;
@property(nonatomic,strong) NSString *name;
@property(nonatomic,strong) NSString *mcd_Price;
@property(nonatomic,strong) NSString *mcd_Share;
@property(nonatomic,strong) NSString *date__c;
@property(nonatomic,strong) NSString *mcd_Time;

@property(strong , nonatomic) NSMutableArray  *merchandizeList;

-(NSString *)GetMaxRnNo;

@end


