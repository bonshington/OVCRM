//
//  NSDictionary+NullHandling.h
//  OVCRM
//
//  Created by Apple on 05/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (NullHandling)

-(id) emptyIfNull:(id)key;
-(id) replaceNilValueWithEmpty;
-(id) coalesce:(id)keys, ... NS_REQUIRES_NIL_TERMINATION;

@end
