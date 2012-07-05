//
//  OVDataWrapper+SQLite.m
//  OVCRM
//
//  Created by Apple on 03/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OVDatabase.h"
#import "SFNativeRestAppDelegate.h"
#import "SFIdentityData.h"
#import "FMDatabase.h"
#import "AppDelegate.h"
#import "NSDictionary+NullHandling.h"

@implementation OVDatabase (FMDB)


-(BOOL) insertOrReplaceTable:(NSString *)tableName 
                     columns:(NSArray *)columns
                        data:(NSArray *)rows{
    
    BOOL result = YES;
    NSMutableArray *args = [NSMutableArray new];
    
    // build 'values' clause
    NSMutableArray *values = [NSMutableArray new];
    [columns enumerateObjectsUsingBlock:^(NSString *columnName, NSUInteger index, BOOL *stop){
        [values addObject:@"?"];
    }];
    
    // build insert or replace clause
    NSString *insertOrReplace = [NSString stringWithFormat:@"insert or replace into %@ (%@) values (%@)", tableName, [columns componentsJoinedByString:@","], [values componentsJoinedByString:@","]];
    
    if(!self.open)[self open];
    
    if([self beginTransaction]){
    
        for(NSDictionary *entry in rows){
            
            [args removeAllObjects];
            
            [columns enumerateObjectsUsingBlock:^(id col,NSUInteger j,BOOL *jStop){
                
                [args addObject:[entry emptyIfNull:col]];
            }];
            
            result = result && [self executeUpdate:insertOrReplace withArgumentsInArray:args];
        }
    }
    return result && [self commit];
 
}





@end
