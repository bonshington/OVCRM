//
//  SFSyncResponder.h
//  OVCRM
//
//  Created by Sopon Srisummasheep on 7/4/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SFRestRequest.h"
#import "OVDatabase.h"
#import "NSString+Extension.h"


@interface SFSyncResponder : NSObject<SFRestDelegate>

+(void) loadWithQuery:(NSString *)query delegate:(id<SFRestDelegate>)responder;

@end
