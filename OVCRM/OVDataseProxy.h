//
//  OVDataseModel.h
//  OVCRM
//
//  Created by Apple on 16/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OVDatabase.h"
#import "OVDatabaseConsumeProtocal.h"
#import "NSDictionary+Extension.h"


@interface OVDataseProxy : NSObject
 
-(bool)OpenConnection;

-(bool)ExecSQL:(NSString *)addText parameterArray:(NSArray *)paramArr;

-(NSMutableArray *)QueryData:(NSString *)sqlText;

@end
