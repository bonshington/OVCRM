//
//  SFObjectProtocal.h
//  OVCRM
//
//  Created by Apple on 06/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SFObjectProtocal <NSObject>

@required
-(NSDictionary *)schema;
-(NSString *) SFName;

@end
