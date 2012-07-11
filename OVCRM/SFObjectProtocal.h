//
//  SFObjectProtocal.h
//  OVCRM
//
//  Created by Apple on 06/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OVSyncProtocal.h"

@protocol SFObjectProtocal <NSObject>

@required
-(void)sync:(id<OVSyncProtocal>)controller;
-(NSDictionary *)schema;
-(NSString *) SFName;
-(NSArray *) toSqlColumn;
-(NSArray *) toSqlColumnWithType;
-(NSArray *) toSqlArguments;
-(NSArray *) toSFColumns;

@end
