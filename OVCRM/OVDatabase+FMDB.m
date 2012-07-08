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
#import "NSDictionary+SFSchema.h"

@implementation OVDatabase (FMDB)

-(BOOL) insertOrReplaceTable:(id<SFObjectProtocal>)object withData:(NSArray *)rows{
    
    NSDictionary *schema = [object schema];
    NSString *script = [NSString stringWithFormat:
                        @"insert or replace into %@ (Id,%@) values(?,%@)"
                        , [object SFName]
                        , [[schema toSqlColumn] componentsJoinedByString:@","]
                        , [[schema toSqlArguments] componentsJoinedByString:@","]
                        ];
    
    BOOL result = YES;
    
    if(!self.open)[self open];
    
    if(result && [self beginTransaction]){
        for(NSDictionary *entry in rows){
            result = result && [self executeUpdate:script withArgumentsInArray:[schema extractSFValueFrom:entry]];
        }
    }
    
    return result && [self commit];
}

-(BOOL) initSqlTableOf:(id<SFObjectProtocal>)object{

    NSString *script = [NSString stringWithFormat:
                        @"create table if not exists %@(Id TEXT primary key,%@)"
                        , [object SFName]
                        , [[[object schema] toSqlColumnWithType] componentsJoinedByString:@","]
                        ];
    
    if(!self.open) [self open];
    
    return [self executeUpdate:script];
}


@end
