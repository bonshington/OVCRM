//
//  SFCallCard.h
//  OVCRM
//
//  Created by Sopon Srisummasheep on 7/11/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import "sObject.h"

@interface SFCallCard : sObject

+(NSArray *)recentCallCard:(int)lookback;

@end
