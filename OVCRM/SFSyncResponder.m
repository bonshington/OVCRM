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




+(void) loadWithQuery:(NSString *)query delegate:(id<SFRestDelegate>)responder{
    
    SFRestRequest *request = [[SFRestAPI sharedInstance] requestForQuery:query];    

    [AppDelegate sharedInstance].sync = responder;

    [[SFRestAPI sharedInstance] send:request delegate:responder];
}

@end
