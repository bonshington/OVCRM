//
//  NSDictionary+Extension.h
//  OVCRM
//
//  Created by Apple on 10/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Extension)

-(id)objectAtIndex:(NSInteger)index;
-(id)objectForKeyLike:(NSString *)key;
-(id) keyAtIndex:(NSInteger)index;

@end
