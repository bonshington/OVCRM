//
//  SFSyncResponder.m
//  OVCRM
//
//  Created by Sopon Srisummasheep on 7/4/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import "SFSyncResponder.h"
#import "AppDelegate.h"

@implementation SFSyncResponder

- (void)request:(SFRestRequest *)request 
didLoadResponse:(id)jsonResponse{
    
    NSLog(@"Got response for: %@", self.class);
    
    OVDatabase *db = [OVDatabase sharedInstance];
    
    if([db initSqlTableOf:self]){
        [db insertOrReplaceTable:self withData:[jsonResponse objectForKey:@"records"]];
    }
    
}

+(void) loadWithQuery:(NSString *)query delegate:(id<SFRestDelegate>)responder{
    
    SFRestRequest *request = [[SFRestAPI sharedInstance] requestForQuery:query];    

    [AppDelegate sharedInstance].sync = responder;

    [[SFRestAPI sharedInstance] send:request delegate:responder];
}

@end
