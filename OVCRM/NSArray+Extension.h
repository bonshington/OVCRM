//
//  NSArray+Extension.h
//  OVCRM
//
//  Created by Apple on 10/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSArray (Extension)

-(NSString *)toJson;

-(id) objectAtIndex:(NSUInteger)index forKey:(id)key;

-(NSMutableDictionary *) dictionaryFromObjectForKey:(id)key;

@end
