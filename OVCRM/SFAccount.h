//
//  SFAccount.h
//  OVCRM
//
//  Created by Sopon Srisummasheep on 7/4/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "sObject.h"

@interface SFAccount : sObject

+ (void) loadAccountsWithRoute:(NSString *)route;

+(NSDictionary *) selectAccountContextOf:(NSString *)accountId;

@end
