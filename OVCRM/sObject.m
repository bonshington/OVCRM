//
//  SFSyncResponder.m
//  OVCRM
//
//  Created by Sopon Srisummasheep on 7/4/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import "sObject.h"
#import "AppDelegate.h"
#import "SFAccount.h"

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
    NSDictionary *mapping = nil;
	
	
	if([self respondsToSelector:@selector(mapping)]){
		mapping = [self mapping];
	}
	
    [[self schema] enumerateKeysAndObjectsUsingBlock:^(NSString *col, NSString *type, BOOL *stop){
        
		NSString *transform = [NSString stringWithString:col];
		
		if(mapping != nil && [mapping objectForKey:col] != nil)
			transform = [mapping objectForKey:col];
		
		
        if([type isEqualToString:@"NUMBER"]){
            [result addObject:[NSString stringWithFormat:@"%@ NUMBER", transform]];
        }
        else{
            [result addObject:[NSString stringWithFormat:@"%@ TEXT", transform]];
        }
    }];
    
    return result;
}

-(NSArray *) toSqlColumn{
	
	if([self respondsToSelector:@selector(mapping)]){
	
		NSDictionary *mapping = [self mapping];
		NSMutableArray *result = [NSMutableArray new];
		
		[[[self schema] allKeys] enumerateObjectsUsingBlock:^(NSString *sfCol, NSUInteger index, BOOL *stop){
			
			NSString *transform = [mapping objectForKey:sfCol];
			
			if(transform != nil)
				[result addObject:transform];
			else
				[result addObject:sfCol];
		}];
		
		return result;
	}
	else{
		return [[self schema] allKeys];
	}
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

+(NSString *)SFNameForSqlTable:(NSString *)table{
	
	NSDictionary *mapping = [NSDictionary dictionaryWithObjectsAndKeys:
							 @"", @"", 
							 nil];
	
	return [mapping objectForKey:table];
}

+(NSDictionary *)mappingForSObject:(NSString *)object{
	
	if([object isEqualToString:@"Account"]){
		return [[SFAccount new] mapping];
	}
	
	return  nil;
}


@end
