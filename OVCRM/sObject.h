//
//  SFSyncResponder.h
//  OVCRM
//
//  Created by Sopon Srisummasheep on 7/4/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SFRestRequest.h"
#import "SFObjectProtocal.h"
#import "OVDatabase.h"
#import "NSString+Extension.h"
#import "NSDictionary+SFSchema.h"
#import "OVSyncProtocal.h"


@interface sObject : NSObject<SFObjectProtocal, SFRestDelegate>

@property (nonatomic, retain) id<OVSyncProtocal> controller;
@property (nonatomic, retain, getter = getAllObject) NSArray *allObject; 
@property (nonatomic, retain, getter = getAllTable) NSDictionary *allTable; 

-(void)sync:(id<OVSyncProtocal>)_controlller where:(NSString *)condition;
-(void)syncRecent:(id<OVSyncProtocal>)_controlller;

+(void) loadWithQuery:(NSString *)query delegate:(id<SFRestDelegate>)responder;

+(NSString *)SFNameForSqlTable:(NSString *)table;

+(NSDictionary *)mappingForSObject:(NSString *)object;

@end
