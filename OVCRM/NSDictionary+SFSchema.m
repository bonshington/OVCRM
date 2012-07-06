//
//  NSDictionary+SFSchema.m
//  OVCRM
//
//  Created by Apple on 06/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NSDictionary+SFSchema.h"

@implementation NSDictionary (SFSchema)

-(NSArray *) toSqlColumnWithType{
    NSMutableArray *result = [NSMutableArray new];
    
    [self enumerateKeysAndObjectsUsingBlock:^(NSString *col, NSString *type, BOOL *stop){
        
        if([type isEqualToString:@"NUMBER"]){
            [result addObject:[NSString stringWithFormat:@"%@ NUMBER", col]];
        }
        else{
            [result addObject:[NSString stringWithFormat:@"%@ TEXT", col]];
        }
    }];
    
    return result;
}

-(NSArray *) toSqlColumn{

    return [self allKeys];
}

-(NSArray *) toSFColumns{
    
    NSMutableArray *result = [NSMutableArray new];
    
    [self enumerateKeysAndObjectsUsingBlock:^(NSString *col, NSString *type, BOOL *stop){
        
        if([type isEqualToString:@"TEXT"] || [type isEqualToString:@"NUMBER"]){
            [result addObject:[NSString stringWithFormat:@"%@", col]];
        }
        else if([type isEqualToString:@"PICKLIST"]){
            [result addObject:[NSString stringWithFormat:@"toLabel(%@)", col]];
        }
        else if([type isEqualToString:@"LOOKUP"]){
            [result addObject:[NSString stringWithFormat:@"%@.Name", col]];
        }
    }];
    
    return result;
}

@end
