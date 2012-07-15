//
//  OVUploadProtocal.h
//  OVCRM
//
//  Created by Sopon Srisummasheep on 7/14/55 BE.
//  Copyright (c) 2555 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol OVUploadProtocal <NSObject>

@required
-(void) updateUploadStatus:(int)tasksLeft;

@end
