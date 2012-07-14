//
//  OVDataWrapper.h
//  OVCRM
//
//  Created by Apple on 03/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SFRestAPI.h"
#import "SFRestRequest.h"
#import "FMDatabase.h"
#import "SFObjectProtocal.h"
#import "NSString+Extension.h"

@interface OVDatabase : FMDatabase

+ (OVDatabase *) sharedInstance;

-(void) registerUpload:(NSString *)name withData:(NSDictionary *)data;

@end



@interface OVDatabase (FMDB)

-(BOOL) initSqlTableOf:(id<SFObjectProtocal>)object;
-(BOOL) insertOrReplaceTable:(id<SFObjectProtocal>)object withData:(NSArray *)rows;

@end




#pragma mark - SalesForce Objects

@interface OVDatabase (SFAccount)

//-(NSArray *) selectByRoute:(NSString *)route;

@end