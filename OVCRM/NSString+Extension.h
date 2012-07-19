//
//  NSString_NSStringExtension.h
//  OVCRM
//
//  Created by Apple on 05/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString(Extension)

-(NSString *) stringByReplace:(NSArray *)array withString:(NSString *)withString;
-(NSString *) htmlEncode;

+(NSString *)guid;

@end
