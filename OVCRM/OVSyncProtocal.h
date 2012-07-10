//
//  OVSyncProtocal.h
//  OVCRM
//
//  Created by Apple on 09/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol OVSyncProtocal <NSObject>

@optional
-(void)updateStatus:(NSString *)status;

@required
-(void)done;

@end
