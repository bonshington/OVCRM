//
//  NSArray+LINQ.m
//  OVCRM
//
//  Created by Apple on 06/07/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NSArray+LINQ.h"

@implementation NSArray (LINQ)

- (NSArray *) where:(BOOL (^)(id))predicate{
    NSMutableArray * retval = [NSMutableArray new];
    
    for (id item in self) {
        if (predicate(item)) { [retval addObject:item]; }
    }
    return retval;
}


@end
