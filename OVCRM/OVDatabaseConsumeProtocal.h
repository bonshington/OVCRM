//
//  OVDatabaseConsumeProtocal.h
//  OVCRM
//
//  Created by Apple on 16/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol OVDatabaseConsumeProtocal <NSObject>

@required
-(NSString *)sqlName;
-(NSString *)DB_Field;

@optional
-(NSString *)DB_Field;
-(NSMutableArray *)QueryData:(NSString *)sqlText;

@end
