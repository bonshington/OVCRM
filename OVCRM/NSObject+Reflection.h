//
//  NSObject+Reflection.h
//  OVCRM
//
//  Created by Apple on 16/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "objc/runtime.h"

@interface NSObject (Reflection)

- (NSDictionary *)properties;

@end
