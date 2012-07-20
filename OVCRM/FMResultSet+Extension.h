//
//  FMResultSet+Extension.h
//  OVCRM
//
//  Created by Apple on 10/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FMResultSet.h"
#import "FMDatabase.h"

@interface FMResultSet (Extension)

-(NSArray *) readToEnd;
-(NSDictionary *) readToEndById;

@end
