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
#import "SFProduct.h"
#import "SFPlan.h"
#import "SFStock.h"
#import "SFMerchandise.h"
#import "SFGoodsReturn.h"
#import "SFCollection.h"
#import "SFCallCard.h"

NSArray *SF_OBJECTS = nil;
NSDictionary *SF_MAPPING = nil;

@implementation sObject

@synthesize controller, allObject, allTable;

-(void)sync:(id<OVSyncProtocal>)_controller where:(NSString *)condition{
	
	self.controller = _controller;
    
	[_controller updateStatus:@"Requesting..."];
	
	NSLog(@"SF query for \"%@\" where %@", [self sfName], condition);
	
	if(condition == nil){
		[sObject loadWithQuery:[NSString stringWithFormat:
								@"select Id,%@ from %@"
								, [[self toSFColumns] componentsJoinedByString:@","]
								, [self sfName]]
					  delegate:self];
	}
	else{
		[sObject loadWithQuery:[NSString stringWithFormat:
								@"select Id,%@ from %@ where %@"
								, [[self toSFColumns] componentsJoinedByString:@","]
								, [self sfName]
								, condition]
					  delegate:self];

	}
	
}

#pragma mark - SFRestDelegate

- (void)request:(SFRestRequest *)request 
didLoadResponse:(id)jsonResponse{
    
    NSLog(@"Got response for: %@", self.class);
    
	if(jsonResponse == nil || ((NSArray *)jsonResponse).count == 0) 
		return;
	
	
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
	
    [self.controller updateStatus:error.localizedDescription];
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

-(NSArray *)getAllObject{
	
	if(SF_OBJECTS == nil){
		SF_OBJECTS = [NSArray arrayWithObjects:
					  [SFAccount new]
					  ,[SFProduct new]
					  ,[SFPlan new]
					  ,[SFStock new]
					  ,[SFMerchandise new]
					  ,[SFGoodsReturn new]
					  ,[SFCollection new]
					  ,[SFCallCard new]
					  , nil];
		
	}
	
	return SF_OBJECTS;
}

-(NSDictionary *) getAllTable{
	
	if(SF_MAPPING == nil){
		NSMutableDictionary *_mapping = [NSMutableDictionary new];
	
		[self.allObject enumerateObjectsUsingBlock:^(sObject *obj, NSUInteger index, BOOL *stop){
			[_mapping setValue:[obj sqlName] forKey:[obj sfName]];
		}];
	
		SF_MAPPING = [NSDictionary dictionaryWithDictionary:_mapping];
	}
		
	return SF_MAPPING;
}


+(void) loadWithQuery:(NSString *)query delegate:(id<SFRestDelegate>)responder{
    
    SFRestRequest *request = [[SFRestAPI sharedInstance] requestForQuery:query];    

    [AppDelegate sharedInstance].sync = responder;

    [[SFRestAPI sharedInstance] send:request delegate:responder];
}

+(NSString *)SFNameForSqlTable:(NSString *)table{
	
	return [[sObject new].allTable objectForKey:table];
}

+(NSDictionary *)mappingForSObject:(NSString *)object{
	
	sObject *this = [self new];
	
	for(sObject *obj in this.allObject){
		if([object isEqualToString:[obj sfName]] || [object isEqualToString:[obj sqlName]]){
			return [obj mapping];
		}
	}
	
	return nil;
}


@end
