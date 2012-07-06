//
//  SFVisit.h
//  OVCRM
//
//  Created by Apple on 05/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//8888888

#import "SFSyncResponder.h"

@interface SFVisit : SFSyncResponder

- (void)request:(SFRestRequest *)request 
didLoadResponse:(id)jsonResponse;

+(void) loadAfterDate:(NSString *)date;

@end
