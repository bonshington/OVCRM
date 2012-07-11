//
//  SFSyncResponder.m
//  OVCRM
//
//  Created by Sopon Srisummasheep on 7/4/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import "sObject.h"
#import "AppDelegate.h"

@implementation sObject

@synthesize controller;

#pragma mark - SFRestDelegate

- (void)request:(SFRestRequest *)request 
didLoadResponse:(id)jsonResponse{
    
    NSLog(@"Got response for: %@", self.class);
    
    [self.controller updateStatus:@"Recieved data"];
    
    OVDatabase *db = [OVDatabase sharedInstance];
    
    if([db initSqlTableOf:self]){
        
        [self.controller updateStatus:@"Processing"];
        
        if([db insertOrReplaceTable:self withData:[jsonResponse objectForKey:@"records"]]){
            [self.controller updateStatus:@"Done"];
        }
        else{
            
            [self.controller updateStatus:@"Failed"];
        }
    }
    
    [self.controller done];
}

- (void)request:(SFRestRequest *)request didFailLoadWithError:(NSError*)error{
    [self.controller updateStatus:@"Error !!"];
}

- (void)requestDidCancelLoad:(SFRestRequest *)request{
    [self.controller updateStatus:@"Cancelled"];
}

- (void)requestDidTimeout:(SFRestRequest *)request{
    [self.controller updateStatus:@"Timeout..."];
}


#pragma mark - sObject

-(NSArray *) toSqlColumnWithType{
    NSMutableArray *result = [NSMutableArray new];
    
    [[self schema] enumerateKeysAndObjectsUsingBlock:^(NSString *col, NSString *type, BOOL *stop){
        
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
	
    return [[self schema] allKeys];
}

-(NSArray *) toSqlArguments{
    
    NSMutableArray *result = [NSMutableArray new];
    
    for(id each in [[self schema] allKeys]){
        [result addObject:@"?"];
    }
    
    return result;
}

-(NSArray *) toSFColumns{
    
    NSMutableArray *result = [NSMutableArray new];
    
    [[self schema] enumerateKeysAndObjectsUsingBlock:^(NSString *col, NSString *type, BOOL *stop){
        
        if([type isEqualToString:@"TEXT"] || [type isEqualToString:@"NUMBER"]){
            [result addObject:col];
        }
        else if([type isEqualToString:@"PICKLIST"]){
            [result addObject:[NSString stringWithFormat:@"toLabel(%@)", col]];
        }
        else if([type isEqualToString:@"LOOKUP"]){
            [result addObject:[NSString stringWithFormat:@"%@.Name", col]];
        }
        else if([type isEqualToString:@"FK"]){
            [result addObject:[NSString stringWithFormat:@"%@.Id", col]];
        }
        else if([type isEqualToString:@"DATETIME"]){
            [result addObject:col];
        }
    }];
    
    return result;
}




+(void) loadWithQuery:(NSString *)query delegate:(id<SFRestDelegate>)responder{
    
    SFRestRequest *request = [[SFRestAPI sharedInstance] requestForQuery:query];    

    [AppDelegate sharedInstance].sync = responder;

    [[SFRestAPI sharedInstance] send:request delegate:responder];
}

@end
