//
//  NSDictionary+SFSchema.h
//  OVCRM
//
//  Created by Apple on 06/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (SFSchema)

-(NSArray *) toSqlColumn;
-(NSArray *) toSqlColumnWithType;
-(NSArray *) toSqlArguments;
-(NSArray *) toSFColumns;

-(NSString *) extractObjectForKey:(NSString *)key withProperty:(NSString *)prop;

-(NSArray *)extractSFValueFrom:(NSDictionary *)json;

@end
