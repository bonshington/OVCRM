//
//  SFVisit.h
//  OVCRM
//
//  Created by Apple on 05/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//8888888
// Test GitHub

#import "sObject.h"

@interface SFVisit : sObject

+(void) loadNewVisit;
+(FMResultSet *) selectToday;

@end
