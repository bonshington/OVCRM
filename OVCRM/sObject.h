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


@interface sObject : NSObject<SFRestDelegate, SFObjectProtocal>

@property (nonatomic, retain) id<OVSyncProtocal> controller;

+(void) loadWithQuery:(NSString *)query delegate:(id<SFRestDelegate>)responder;

+(NSString *)SFNameForSqlTable:(NSString *)table;

+(NSDictionary *)mappingForSObject:(NSString *)object;

@end
