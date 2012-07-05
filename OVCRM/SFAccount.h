//
//  SFAccount.h
//  OVCRM
//
//  Created by Sopon Srisummasheep on 7/4/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SFSyncResponder.h"

@interface SFAccount : SFSyncResponder <SFRestDelegate>

- (void)request:(SFRestRequest *)request 
didLoadResponse:(id)jsonResponse;

+(void) loadAccountsWithRoute:(NSString *)route;

//+(void) selectAccount

@end
